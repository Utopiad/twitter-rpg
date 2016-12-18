class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :character_type_id
      t.integer :user_id
      t.integer :world_id
      t.text :name
      t.text :slug
      t.string :image
      t.integer :total_experience, default: 0
      t.integer :bonus_attack, default: 0
      t.integer :bonus_armor, default: 0
      t.integer :bonus_life, default: 0
      t.integer :malus_life, default: 0
      t.integer :is_narrator, default: 0
      t.integer :has_played, default: 0

      t.timestamps
    end
  end
end
