# frozen_string_literal: true

load 'image_uploader.rb'

class Chapter < ApplicationRecord
  include Activable
  mount_uploader :picture, PictureUploader

  belongs_to :world
  has_many :events, dependent: :destroy

  mount_uploader :image, ChapterImageUploader

  def activate_event!(event)
    return false unless event.chapter.id == id && active?

    events.where(active: 1).find_all.map(&:deactivate!)
    event.activate!
  end
end
