class Monster < ApplicationRecord
  belongs_to :world
  has_many :event_monsters
end
