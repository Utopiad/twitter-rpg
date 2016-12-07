require 'rails_helper'

RSpec.describe Character, type: :model do

  it 'can be named' do
     name = 'Jack'
     character = Character.new(name: name)
     expect(character.name).to eq(name)
   end

   it 'needs a world, a user different from game master and a classe' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     character = Character.new(name:'crepe')
     # needs world
     expect(character.save).to eq(false)
     character.world_id= world.id
     # needs user
     expect(character.save).to eq(false)
     character.user_id = game_master.id
     # needs classe
     expect(character.save).to eq(false)
     classe_fantassin = Classe.new(
        name: "Fantassin",
        attack_min: 2,
        attack_max: 8,
        armor: 4,
        life: 12,
        world_id: world.id
      )
      classe_fantassin.save
      character.classe_id = classe_fantassin.id
      # puts character.inspect
      # needs user different from game_master
      expect(character.save).to eq(false)
      true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
      true_gamer.save
      character.user_id = true_gamer.id
      expect(character.save).to eq(true)
   end

   it 'can fight a character' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      gamer_adverse = User.new(email: "un_vrai_deuxieme_joueur@gmail.com", password: "auberge_poney_fringant")
      gamer_adverse.save
      character_adverse = Character.new(
         name: 'vlaboutix',
         world_id: world.id,
         classe_id: classe_fantassin.id,
         user_id: gamer_adverse.id
      )
      character_adverse.save
      expect(character.fight(defender: character_adverse)).to eq(true)
   end

   it 'loses life in a fight' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      gamer_adverse = User.new(email: "un_vrai_deuxieme_joueur@gmail.com", password: "auberge_poney_fringant")
      gamer_adverse.save
      classe_gronul = Classe.new(
        name: "Gros Nul",
        attack_min: 1,
        attack_max: 3,
        armor: 0,
        life: 2,
        world_id: world.id
      )
      classe_gronul.save
      character_adverse = Character.new(
         name: 'vlaboutix',
         world_id: world.id,
         classe_id: classe_gronul.id,
         user_id: gamer_adverse.id
      )
      character_adverse.save
      initial_life = character_adverse.classe.life
      character.fight(defender: character_adverse)
      expect(character_adverse.current_life == initial_life).to eq(false)
   end

   it 'can\'t fight himself' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      expect(character.fight(defender: character)).to eq(false)
   end

   it 'can\'t fight a user' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      expect(character.fight(defender: game_master)).to eq(false)
   end

   it 'can\'t fight a world' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      expect(character.fight(defender: world)).to eq(false)
   end

   it 'can\'t fight a class' do
     game_master = User.new(email: "babar@gmail.com", password: "rabab")
     game_master.save
     world = World.new(user: game_master, name: "bigelow")
     world.save
     classe_fantassin = Classe.new(
       name: "Fantassin",
       attack_min: 2,
       attack_max: 8,
       armor: 4,
       life: 12,
       world_id: world.id
     )
     classe_fantassin.save
     true_gamer = User.new(email: "un_vrai_joueur@gmail.com", password: "goldOverwatch")
     true_gamer.save
     character = Character.new(
        name:'crepe',
        world_id: world.id,
        classe_id: classe_fantassin.id,
        user_id: true_gamer.id
      )
      character.save
      expect(character.fight(defender: classe_fantassin)).to eq(false)
   end
end
