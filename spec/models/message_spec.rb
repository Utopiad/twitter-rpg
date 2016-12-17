require 'rails_helper'

RSpec.describe Message, type: :model do

  it 'has a message and comes from a character' do
    text_piece = "Let\'s smash them hard!"
    message = Message.new(message: text_piece)

    expect(message.save).to eq(false)

    u = User.new(
      email:'holamaster@gmail.fr',
      password: 'zezette09'
    )
    u.save

    gamer = User.new(
      email:'sombrero_amarillo@gmail.fr',
      password: 'jgvhfcjhnlk'
    )
    gamer.save

    w = World.new(
      user_id: u.id,
      name:"Equestria",
      public: 0,
      max_character_count: 5
    )
    w.save

    race = CharacterType.new(
      name: 'gronul',
      world_id: w.id,
      attack_min: 1,
      attack_max: 5,
      armor: 0,
      life: 8
    )
    race.save

    character = Character.new(
      user_id: gamer.id,
      character_type_id: race.id,
      name: "Vraële"
    )
    character.save

    chapter = Chapter.new(
      title: "Ragnarok",
      description: "Apocalypse Now",
      image: "c_la_fin.jpg",
      world_id: w.id
    )
    chapter.save

    event = Event.new(
      title: 'No quarter until death',
      description: 'Kill all the monsters',
      image: 'zipo.jpg',
      chapter_id: chapter.id
    )
    event.save

    message.character_id = character.id
    message.event_id = event.id

    expect(message.save).to eq(true)
  end

  it 'doesn\'t save empty messages' do

    u = User.new(
      email:'holamaster@gmail.fr',
      password: 'zezette09'
    )
    u.save

    gamer = User.new(
      email:'sombrero_amarillo@gmail.fr',
      password: 'jgvhfcjhnlk'
    )
    gamer.save

    w = World.new(
      user_id: u.id,
      name:"Equestria",
      public: 0,
      max_character_count: 5
    )
    w.save

    race = CharacterType.new(
      name: 'gronul',
      world_id: w.id,
      attack_min: 1,
      attack_max: 5,
      armor: 0,
      life: 8
    )
    race.save

    character = Character.new(
      user_id: gamer.id,
      character_type_id: race.id,
      name: "Vraële"
    )
    character.save

    chapter = Chapter.new(
      title: "Ragnarok",
      description: "Apocalypse Now",
      image: "c_la_fin.jpg",
      world_id: w.id
    )
    chapter.save

    event = Event.new(
      title: 'No quarter until death',
      description: 'Kill all the monsters',
      image: 'zipo.jpg',
      chapter_id: chapter.id
    )
    event.save

    message = Message.new(
      message: '',
      character_id: character.id,
      event_id: event.id
    )

    expect(message.save).to eq(false)
  end

  it 'is accessible by word reference' do
    u = User.new(
      email:'holamaster@gmail.fr',
      password: 'zezette09'
    )
    u.save

    gamer = User.new(
      email:'sombrero_amarillo@gmail.fr',
      password: 'jgvhfcjhnlk'
    )
    gamer.save

    w = World.new(
      user_id: u.id,
      name:"Equestria",
      public: 0,
      max_character_count: 5
    )
    w.save

    race = CharacterType.new(
      name: 'gronul',
      world_id: w.id,
      attack_min: 1,
      attack_max: 5,
      armor: 0,
      life: 8
    )
    race.save

    character = Character.new(
      user_id: gamer.id,
      character_type_id: race.id,
      name: "Vraële"
    )
    character.save

    chapter = Chapter.new(
      title: "Ragnarok",
      description: "Apocalypse Now",
      image: "c_la_fin.jpg",
      world_id: w.id
    )
    chapter.save

    event = Event.new(
      title: 'No quarter until death',
      description: 'Kill all the monsters',
      image: 'zipo.jpg',
      chapter_id: chapter.id
    )
    event.save

    message = Message.new(
      message: 'Hello there !',
      character_id: character.id,
      event_id: event.id
    )

    message.save

    w.messages.each do |txt|
      if txt.id == message.id
        expect(txt.message).to eq("Hello there !")
      end
    end
  end
end
