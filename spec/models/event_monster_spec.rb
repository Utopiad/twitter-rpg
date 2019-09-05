# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe EventMonster, type: :model do
  it 'needs a world' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
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
      world: world,
      monster: monster
    )
    expect(event_monster.world).to eq(world)
  end

  it 'can fight an event_monster' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'gronul',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    second_monster = Monster.new(
      name: 'laidron',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 10
    )
    event_monster_adverse = EventMonster.new(
      monster: second_monster,
      world: world
    )
    event_monster_adverse.save
    expect(event_monster.fight(defender: event_monster_adverse)).to eq(true)
  end

  it 'loses life in a fight' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'Gronul',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 10,
      armor: 3
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    second_monster = Monster.new(
      name: 'Laidron',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 8,
      armor: 0
    )
    event_monster_adverse = EventMonster.new(
      monster: second_monster,
      world: world
    )
    event_monster_adverse.save
    event_monster_adverse_initial_life = event_monster_adverse.monster.life
    event_monster.fight(defender: event_monster_adverse)
    expect(event_monster_adverse_initial_life == event_monster_adverse.current_life).to eq(false)
  end

  it 'can\'t fight itself' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'gronul',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    expect(event_monster.fight(defender: event_monster)).to eq(false)
  end

  it 'can\'t fight a user' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'gronul',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    expect(event_monster.fight(defender: u)).to eq(false)
  end

  it 'can\'t fight a world' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'gronul',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    expect(event_monster.fight(defender: world)).to eq(false)
  end

  it 'can\'t fight a monster' do
    u = User.new(email: 'babar@gmail.com', password: 'rabab')
    u.save
    world = World.new(user: u, name: 'bigelow')
    world.save
    monster = Monster.new(
      name: 'gronul',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster.save
    event_monster = EventMonster.new(
      world: world,
      monster: monster
    )
    event_monster.save
    expect(event_monster.fight(defender: monster)).to eq(false)
  end
end
