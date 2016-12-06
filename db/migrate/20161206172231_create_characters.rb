class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :world_id
      t.integer :classe_id
      t.integer :user_id
      t.text :name
      t.integer :total_experience, default: 0
      t.integer :bonus_attack_min, default: 0
      t.integer :bonus_attack_max, default: 0
      t.integer :bonus_armor, default: 0
      t.integer :bonus_life, default: 0
      t.integer :malus_life, default: 0

      t.timestamps
    end
  end
end
