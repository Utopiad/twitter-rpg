class World < ApplicationRecord
  alias_attribute :game_master, :user

  belongs_to :user

  has_many :character_types, dependent: :destroy
  has_many :monsters, dependent: :destroy
  has_many :chapters, dependent: :destroy

  has_many :characters, through: :character_types
  has_many :events, through: :chapters
  has_many :messages, through: :characters

  validates :name, presence: true

  def activate_chapter!(chapter)
    return false unless chapter.world.id == self.id
    self.chapters.where(active: 1).find_all.map{ |chapter| chapter.deactivate! }
    chapter.activate!
  end

  def activate_event!(event)
    return false unless event.chapter.world.id == self.id
    event.chapter.activate_event!(event)
  end

  def current_chapter
    self.chapters.find_all.each do |c|
      return c if c.active?
    end
  end
  def current_event
    return false if self.current_chapter.blank?
    self.current_chapter.events.find_all do |e|
      return e if e.active?
    end
  end

  # def messages
  #   self.characters.map{ |c| c.messages }.flatten
  # end
end
