class CreateFights < ActiveRecord::Migration[5.0]
  def change
    create_table :fights do |t|
      t.references :attacker, polymorphic: true, index: true
      t.references :defender, polymorphic: true, index: true

      t.integer :attacker_attack_min
      t.integer :attacker_attack_max
      t.integer :attacker_armor
      t.integer :attacker_life
      t.integer :attacker_malus_life
      t.integer :defender_attack_min
      t.integer :defender_attack_max
      t.integer :defender_armor
      t.integer :defender_life
      t.integer :defender_malus_life

      t.integer :hit

      t.timestamps
    end
  end
end
