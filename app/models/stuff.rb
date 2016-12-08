class Stuff < ApplicationRecord
  belongs_to :world
  has_many :inventories
  has_many :characters, through: :inventories


end
