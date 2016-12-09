class CreateMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :monsters do |t|
      t.integer :world_id
      t.text :name
      t.integer :attack_min, default: 0
      t.integer :attack_max, default: 0
      t.integer :armor, default: 0
      t.integer :life, default: 0
      t.integer :malus_life, default: 0

      t.timestamps
    end
  end
end
