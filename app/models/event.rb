class Event < ApplicationRecord
  belongs_to :chapter
  has_many :event_monsters, dependent: :destroy
  has_many :monsters, through: :event_monsters

  has_many :turns

  has_many :rewards, dependent: :destroy
  has_many :stuffs, through: :rewards

  delegate :world, :to => :chapter
end
