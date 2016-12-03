class World < ApplicationRecord
  belongs_to :user
  has_many :map
end
