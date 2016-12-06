class CreateMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :monsters do |t|
      t.integer :world_id
      t.text :name
      t.integer :attack_min
      t.integer :attack_max
      t.integer :armor
      t.integer :life

      t.timestamps
    end
  end
end
