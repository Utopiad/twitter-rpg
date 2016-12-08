require 'rails_helper'
require 'spec_helper'

RSpec.describe Monster, type: :model do

  it 'can be named' do
    name = 'monstery'
    monster = Monster.new(name: name)
    expect(monster.name).to eq(name)
  end

  it 'needs a world' do
    name = "bigelow"
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: name)
    world.save
    monster  = Monster.new(name:'crepe')
    expect(monster.save).to eq(false)
    monster.world_id= world.id
    expect(monster.save).to eq(true)
    expect(monster.world_id).to eq(world.id)
  end

  it 'can fight a monster' do
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: "bigelow")
    world.save
    monster = Monster.new(
      name: 'crepe',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 10
    )
    monster.save
    monster_adverse = Monster.new(
      name: 'vlaboutix',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 10,
      armor: 12
    )
    monster_adverse.save
    expect(monster.fight(defender: monster_adverse)).to eq(true)
  end

  it 'loses life in a fight' do
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: "bigelow")
    world.save
    monster = Monster.new(
      name: 'crepe',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 10,
      armor: 5
    )
    monster.save
    monster_adverse = Monster.new(
      name: 'vlaboutix',
      world_id: world.id,
      attack_min: 1,
      attack_max: 4,
      life: 8,
      armor: 0
    )
    monster_adverse.save
    initial_life = monster_adverse.life
    monster.fight(defender: monster_adverse)
    expect(monster_adverse.current_life == initial_life).to eq(false)
  end

  it 'can\'t fight itself' do
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: "bigelow")
    world.save
    monster = Monster.new(
      name: 'crepe',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 5
    )
    monster.save
    expect(monster.fight(defender: monster)).to eq(false)
  end

  it 'can\'t fight a user' do
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: "bigelow")
    world.save
    monster = Monster.new(
      name: 'crepe',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 5
    )
    monster.save
    expect(monster.fight(defender: u)).to eq(false)
  end

  it 'can\'t fight a world' do
    u = User.new(email: "babar@gmail.com", password: "rabab")
    u.save
    world = World.new(user: u, name: "bigelow")
    world.save
    monster = Monster.new(
      name: 'crepe',
      world_id: world.id,
      attack_min: 2,
      attack_max: 6,
      life: 8,
      armor: 5
    )
    monster.save
    expect(monster.fight(defender: world)).to eq(false)
  end


end
