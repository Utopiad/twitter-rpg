class CreateStuffs < ActiveRecord::Migration[5.0]
  def change
    create_table :stuffs do |t|
      t.integer :world_id
      t.integer :bonus_attack_min
      t.integer :bonus_attack_max
      t.integer :bonus_armor
      t.integer :bonus_life
      t.string :name

      t.timestamps
    end
  end
end
