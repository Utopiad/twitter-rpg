load 'image_uploader.rb'

class Event < ApplicationRecord
  include Activable
  belongs_to :chapter
  has_many :event_monsters, dependent: :destroy
  has_many :monsters, through: :event_monsters

  has_many :turns

  has_many :rewards, dependent: :destroy
  has_many :stuffs, through: :rewards

  has_many :messages

  delegate :world, :to => :chapter

  mount_uploader :image, EventImageUploader
end
