# frozen_string_literal: true

class CreateStuffs < ActiveRecord::Migration[5.0]
  def change
    create_table :stuffs do |t|
      t.integer :world_id
      t.integer :bonus_attack
      t.integer :bonus_armor
      t.integer :bonus_life
      t.string :name
      t.string :slug
      t.string :image

      t.timestamps
    end
  end
end
