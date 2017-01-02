class CreateCharacterTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :character_types do |t|
      t.text :name
      t.integer :world_id, nullable: true
      t.integer :attack_min, default: 0
      t.integer :attack_max, default: 0
      t.integer :armor, default: 0
      t.integer :life, default: 0

      t.timestamps
    end
  end
end
