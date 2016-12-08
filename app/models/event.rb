class Event < ApplicationRecord
  belongs_to :chapter
  has_many :event_monsters, dependent: :destroy
  has_many :monsters, through: :event_monsters
  has_many :turns
end
