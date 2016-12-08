class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :character_id
      t.integer :world_id
      t.text :message
      t.integer :event_id

      t.timestamps
    end
  end
end
