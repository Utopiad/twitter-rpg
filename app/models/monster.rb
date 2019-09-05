# frozen_string_literal: true

load 'image_uploader.rb'

class Monster < ApplicationRecord
  belongs_to :world
  has_many :event_monsters, dependent: :destroy
  has_many :events, through: :event_monsters

  mount_uploader :image, MonsterImageUploader
end
