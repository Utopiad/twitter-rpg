class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.integer :quantity
      t.integer :event_id
      t.integer :stuff_id

      t.timestamps
    end
  end
end
