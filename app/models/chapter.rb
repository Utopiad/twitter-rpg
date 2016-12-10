class Chapter < ApplicationRecord
  include Activable
  belongs_to :world
  has_many :events, dependent: :destroy


  def activate_event(event)
    return false unless event.chapter.id == self.id && self.active?
    self.events.active.map{ |event| event.deactivate! }
    event.activate!
  end
end
