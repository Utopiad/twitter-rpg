class World < ApplicationRecord
  alias_attribute :game_master, :user
  alias_attribute :narrator, :character


  belongs_to :user
  has_one :narrator, class_name: :Character, foreign_key: :character_id

  has_many :character_types, dependent: :destroy
  has_many :monsters, dependent: :destroy
  has_many :chapters, dependent: :destroy

  has_many :characters, through: :character_types
  has_many :events, through: :chapters
  has_many :messages, through: :characters

  validates :name, presence: true

  def character
    Character.find(self.character_id)
  end

  def character=(character)
    self.character_id = character.id
    self.save
  end

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
