# frozen_string_literal: true

class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :world_id
      t.integer :active, default: 1

      t.timestamps
    end
  end
end
