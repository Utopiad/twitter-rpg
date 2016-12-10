class CreateEventMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :event_monsters do |t|
      t.integer :monster_id
      t.integer :event_id
      t.integer :bonus_attack, default: 0
      t.integer :bonus_life, default: 0
      t.integer :bonus_armor, default: 0
      t.integer :malus_life, default: 0
      t.string :name

      t.timestamps
    end
  end
end
