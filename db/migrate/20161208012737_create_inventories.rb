class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :character_id
      t.integer :stuff_id
      t.integer :used
      t.integer :equiped

      t.timestamps
    end
  end
end
