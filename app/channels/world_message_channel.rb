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

    if message.save
      ActionCable.server.broadcast(channel, message: render_message(message))
    end

    fight = self.check_action(message)

    if fight
      fight_message = Message.new(character: message.character,
        event_id: data['event_id'], message: fight.export(:txt))
      if fight_message.save
        ActionCable.server.broadcast(channel, message: render_message(fight_message))
      end
    end


  end

  def check_action(message)
    reg = Regexp.new(/(\B#\w\w+)\s(\B@\w\w+)/)
    actions = message.message.scan(reg)
    actions.each do |action|
      if action[0] == "#attack"
        target = EventMonster.where(slug: action[1]).first
        puts target.blank?
        if target.blank?
          target = message.character.world.characters.where(slug: action[1]).first
          puts target
          return false if target.blank?
          return message.character.attack(target)
        end
      else
        return false
      end
    end
    return false
  end

  def render_message(message)
    ApplicationController.render(
      partial: 'message/message',
      locals: {
        message: message,
      })
  end
end
