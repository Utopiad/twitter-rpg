load 'image_uploader.rb'

class Chapter < ApplicationRecord
  include Activable
  mount_uploader :picture, PictureUploader

  belongs_to :world
  has_many :events, dependent: :destroy

  mount_uploader :image, ChapterImageUploader

  def activate_event!(event)
    return false unless event.chapter.id == self.id && self.active?
    self.events.where(active: 1).find_all.map{ |event| event.deactivate! }
    event.activate!
  end
end
