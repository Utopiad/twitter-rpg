# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  u = User.create(email: 'martinziserman@gmail.com',
                  password: 'aaaaaa', name: 'Martin')

  u2 = User.create(email: 'bono@gmail.com',
                   password: 'u2u2u2', name: 'Bono')

  1.times do
    w = World.create(user: u, name: Forgery(:internet).user_name,
                     max_character_count: rand(2..10), public: 1)

    w2 = World.create(user: u2, name: Forgery(:internet).user_name,
                      max_character_count: rand(2..10), public: 1)

    1.times do
      c = CharacterType.create(world: w, name: Forgery(:internet).user_name,
                               attack_min: rand(1..3), attack_max: rand(3..10), armor: rand(1..3),
                               life: rand(6..10))
      m = Monster.create(world: w, name: Forgery(:internet).user_name,
                         attack_min: rand(1..3), attack_max: rand(3..10), armor: rand(1..3),
                         life: rand(6..10))
      s = Stuff.create(world: w, name: Forgery(:internet).user_name,
                       bonus_attack: rand(0..3), bonus_armor: rand(0..3),
                       bonus_life: rand(0..3))

      1.times do
        ch = Character.create(character_type: c, user: u,
                              name: Forgery(:internet).user_name, world: w)
        i = Inventory.create(character: ch, stuff: s)
        1.times do
          chap = Chapter.create(description: Forgery('lorem_ipsum').paragraph,
                                world: w, title: Forgery('lorem_ipsum').sentence, active: 1)

          3.times do
            e = Event.create(chapter: chap, description: Forgery('lorem_ipsum').paragraph,
                             title: Forgery('lorem_ipsum').sentence, active: 1)
            1.times do
              em = EventMonster.create(monster: m, event: e,
                                       name: Forgery(:internet).user_name)
              r = Reward.create(event: e, stuff: s)
              t = Turn.create(event: e, finished: 0)
              # 1.times do
              #   # mes = Message.create(character: ch, message: Forgery('lorem_ipsum').paragraph)
              # end
            end
          end
        end
      end

      1.times do
        ch2 = Character.create(character_type: c, user: u2,
                               name: Forgery(:internet).user_name, world: w2)
        i2 = Inventory.create(character: ch2, stuff: s)
        1.times do
          chap2 = Chapter.create(description: Forgery('lorem_ipsum').paragraph,
                                 world: w2, title: Forgery('lorem_ipsum').sentence, active: 1)

          1.times do
            e2 = Event.create(chapter: chap2, description: Forgery('lorem_ipsum').paragraph,
                              title: Forgery('lorem_ipsum').sentence, active: 1)
            1.times do
              em2 = EventMonster.create(monster: m, event: e2,
                                        name: Forgery(:internet).user_name)
              r2 = Reward.create(event: e2, stuff: s)
              t2 = Turn.create(event: e2, finished: 0)
              # 1.times do
              #   # mes = Message.create(character: ch2, message: Forgery('lorem_ipsum').paragraph)
              # end
            end
          end
        end
      end

      1.times do
        ch3 = Character.create(character_type: c, user: u2,
                               name: Forgery(:internet).user_name, world: w)
        i3 = Inventory.create(character: ch3, stuff: s)
        1.times do
          chap3 = Chapter.create(description: Forgery('lorem_ipsum').paragraph,
                                 world: w, title: Forgery('lorem_ipsum').sentence, active: 1)

          1.times do
            e3 = Event.create(chapter: chap3, description: Forgery('lorem_ipsum').paragraph,
                              title: Forgery('lorem_ipsum').sentence, active: 1)
            1.times do
              em3 = EventMonster.create(monster: m, event: e3,
                                        name: Forgery(:internet).user_name)
              r3 = Reward.create(event: e3, stuff: s)
              t3 = Turn.create(event: e3, finished: 0)
              1.times do
                # mes = Message.create(character: ch3, message: Forgery('lorem_ipsum').paragraph)
              end
            end
          end
        end
      end
    end
  end
end
