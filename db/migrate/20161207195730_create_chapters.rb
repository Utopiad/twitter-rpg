class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :description
      t.string :image
      t.references :world, foreign_key: true

      t.timestamps
    end
  end
end
