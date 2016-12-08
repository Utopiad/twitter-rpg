class Stuff < ApplicationRecord
  belongs_to :world
  # many to many events
  has_many :inventories
  has_many :characters, through: :inventories
end
