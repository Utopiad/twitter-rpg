# frozen_string_literal: true

class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.integer :quantity, default: 0
      t.integer :event_id
      t.integer :stuff_id
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
