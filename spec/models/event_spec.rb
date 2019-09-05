# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'needs a chapter' do
    u = User.new(email: 'master_guy@life.com', password: 'bamboulabambouli')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    chapter = Chapter.new(
      world: world,
      title: 'Elections Présidentielles 2017',
      description: 'Marine Le Pen passera-t-elle ?',
      world_id: world.id
    )
    chapter.save
    event = Event.new(
      title: 'A l\'assaut !'
    )
    expect(event.save).to eq(false)
    event.chapter_id = chapter.id
    expect(event.save).to eq(true)
  end

  it 'can have an event_monster' do
    u = User.new(email: 'master_guy@life.com', password: 'bamboulabambouli')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    chapter = Chapter.new(
      world: world,
      title: 'Elections Présidentielles 2017',
      description: 'Marine Le Pen passera-t-elle ?',
      world_id: world.id
    )
    chapter.save
    monster = Monster.new(
      name: 'laidron',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 10
    )
    monster.save
    event_monster = EventMonster.new(
      monster: monster
    )
    event_monster.save
    event_monster_adverse = EventMonster.new(
      monster: monster
    )
    event_monster_adverse.save
    the_monsters = [event_monster, event_monster_adverse]
    event = Event.new(
      title: 'A l\'assaut !',
      chapter_id: chapter.id,
      event_monsters: the_monsters
    )
    expect(event.save).to eq(true)
  end

  it 'can have many events_monsters' do
    puts 'something to do'
  end

  it 'destroys itself if all events_monster are dead' do
    puts 'something to do'
  end
end
