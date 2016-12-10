class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :character_id
      t.integer :stuff_id
      t.integer :used, default: 0
      t.integer :equiped, default: 0

      t.timestamps
    end
  end
end
