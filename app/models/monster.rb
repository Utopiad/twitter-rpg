class Monster < ApplicationRecord
  belongs_to :world
  has_many :event_monsters, dependent: :destroy
  has_many :events, through: :event_monsters
end
