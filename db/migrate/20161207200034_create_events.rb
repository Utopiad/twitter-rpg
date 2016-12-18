class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :chapter_id
      t.integer :active, default: 0

      t.timestamps
    end
  end
end
