# frozen_string_literal: true

load 'image_uploader.rb'

class Stuff < ApplicationRecord
  include Sluggable
  belongs_to :world

  has_many :rewards, dependent: :destroy
  has_many :events, through: :rewards

  has_many :inventories, dependent: :destroy
  has_many :characters, through: :inventories

  mount_uploader :image, StuffImageUploader
end
