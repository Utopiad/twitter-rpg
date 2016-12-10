class CreateCharacterTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :character_types do |t|
      t.text :name
      t.integer :world_id
      t.integer :attack_min
      t.integer :attack_max
      t.integer :armor
      t.integer :life

      t.timestamps
    end
  end
end
