class CreateFights < ActiveRecord::Migration[5.0]
  def change
    create_table :fights do |t|
      t.references :attacker, polymorphic: true, index: true
      t.references :defender, polymorphic: true, index: true

      t.integer :hit

      t.timestamps
    end
  end
end
