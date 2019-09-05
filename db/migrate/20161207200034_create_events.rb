# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :chapter_id
      t.integer :active, default: 1

      t.timestamps
    end
  end
end
