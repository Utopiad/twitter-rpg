class CreateEventMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :event_monsters do |t|
      t.integer :world_id
      t.integer :monster_id
      t.integer :bonus_attack_min, default: 0
      t.integer :bonus_attack_max, default: 0
      t.integer :bonus_life, default: 0
      t.integer :bonus_armor, default: 0
      t.integer :malus_life, default: 0
      t.string :name

      t.timestamps
    end
  end
end