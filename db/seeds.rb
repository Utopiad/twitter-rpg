# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  u = User.create(email: Forgery(:internet).email_address,
    password: Forgery(:basic).password)

  2.times do
    w = World.create(user: u, name: Forgery(:internet).user_name,
      max_character_count: rand(2..10), public: 1)

    2.times do
      c = CharacterType.create(world: w, name: Forgery(:internet).user_name,
        attack_min: rand(1..3), attack_max: rand(3..10), armor: rand(1..3),
        life: rand(6..10))
      m = Monster.create(world: w, name: Forgery(:internet).user_name,
        attack_min: rand(1..3), attack_max: rand(3..10), armor: rand(1..3),
        life: rand(6..10))
      s = Stuff.create(world: w, name: Forgery(:internet).user_name,
        bonus_attack: rand(0..3), bonus_armor: rand(0..3),
        bonus_life: rand(0..3))

      2.times do
        ch = Character.create(character_type: c, user: u,
          name: Forgery(:internet).user_name)
        i = Inventory.create(character: ch, stuff: s)
        2.times do
          chap = Chapter.create(description: Forgery('lorem_ipsum').paragraph,
            world: w, title: Forgery('lorem_ipsum').sentence)

          2.times do
            e = Event.create(chapter: chap, description: Forgery('lorem_ipsum').paragraph,
              title: Forgery('lorem_ipsum').sentence)
            2.times do
              em = EventMonster.create(monster: m, event: e,
                name: Forgery(:internet).user_name)
              r = Reward.create(event: e, stuff: s)
              t = Turn.create(event: e, finished: 0)
              2.times do
                # mes = Message.create(character: ch, message: Forgery('lorem_ipsum').paragraph)
              end
            end
          end
        end
      end
    end


  end
end
