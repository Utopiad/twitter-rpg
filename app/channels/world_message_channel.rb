# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class WorldMessageChannel < ApplicationCable::Channel
  def subscribed
    template = 'messages_%s'
    channel = template % [params[:world_id]]
    stream_from channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    template = 'messages_%s'
    channel = template % [data['world_id']]
    message = Message.new(character_id: data['character_id'],
      event_id: data['event_id'], message: data['message'])
    event_id = data['event_id']
    character = message.character

    if message.save
      ActionCable.server.broadcast(channel, message: render_message(message))
    end
    if character.is_narrator?
      self.monster_attack(message, character, event_id, channel)
      self.attribute(message, character, event_id, channel)
      self.pass_turn(message, character, event_id, channel)
    else
      self.attack(message, character, event_id, channel)
    end
  end

  def attribution_message(character, stuff, target, event_id, channel)
    template = "%s a récompensé %s d'un %s"
    message = template % [character.name, target.name, stuff.name]
    attribution_message = Message.new(character: character,
      event_id: event_id, message: message)
    if attribution_message.save
      ActionCable.server.broadcast(channel, message: render_message(attribution_message))
    end
  end

  def fight_message(fight, character, event_id, channel)
    fight_message = Message.new(character: character,
      event_id: event_id, message: fight.export(:txt))
    if fight_message.save
      ActionCable.server.broadcast(channel, message: render_message(fight_message))
    end
  end

  def pass_turn_message(character, event_id, channel)
    template = "%s a mis fin au tour. Vous pouvez maintenant tous jouer."
    message = template % [character.name]
    pass_turn_message = Message.new(character: character,
      event_id: event_id, message: message)
    if pass_turn_message.save
      ActionCable.server.broadcast(channel, message: render_message(pass_turn_message))
    end
  end

  def pass_turn(message, character, event_id, channel)
    reg = Regexp.new(/(\B#\w\w+)/)
    actions = message.message.scan(reg)

    actions.each do |action|
      if action[0] == "#pass_turn"
        event = Event.find(event_id)
        event.pass_turn
        self.pass_turn_message(character, event_id, channel)
      end
    end

  end

  def attack(message, character, event_id, channel)
    reg = Regexp.new(/(\B#\w\w+)\s(\B@\w\w+)/)
    actions = message.message.scan(reg)
    return false if character.has_played?
    actions.each do |action|
      if action[0] == "#attack"
        target = EventMonster.where(slug: action[1]).first
        unless target.blank?
          fight = character.attack(target)
          self.fight_message(fight, character, event_id, channel)
        else
          target = message.character.world.characters.where(slug: action[1]).first
          return false if target.blank?
          fight = character.attack(target)
          self.fight_message(fight, character, event_id, channel)
        end
      else
        return false
      end
    end
  end

  def attribute(message, character, event_id, channel)
    reg = Regexp.new(/(\B#\w\w+)\s(\B@\w\w+)\s(\B@\w\w+)/)
    actions = message.message.scan(reg)

    actions.each do |action|
      if action[0] == "#attribute"
        reward = Reward.where(slug: action[1]).first
        return false if reward.blank?

        target = message.character.world.characters.where(slug: action[2]).first
        unless target.blank?
          attribution = reward.attribute_to(target)
          self.attribution_message(character, reward.stuff, target, event_id, channel)
        end
      else
        return false
      end
    end
  end

  def monster_attack(message, character, event_id, channel)
    reg = Regexp.new(/(\B@\w\w+)\s(\B#\w\w+)\s(\B@\w\w+)/)
    actions = message.message.scan(reg)

    actions.each do |action|
      if action[1] == "#attack"
        attacker = EventMonster.where(slug: action[0]).first
        return false if attacker.has_played?

        target = EventMonster.where(slug: action[2]).first
        unless target.blank?
          fight = attacker.attack(target)
          self.fight_message(fight, character, event_id, channel)
        else
          target = message.character.world.characters.where(slug: action[2]).first
          return false if target.blank?
          fight = attacker.attack(target)
          self.fight_message(fight, character, event_id, channel)
        end
      else
        return false
      end
    end
  end

  def render_message(message)
    ApplicationController.render(
      partial: 'message/message',
      locals: {
        message: message,
      })
  end
end
