class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.integer :event_id
      t.integer :finished, default: 0

      t.timestamps
    end
  end
end
