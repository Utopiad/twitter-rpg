class World < ApplicationRecord
  alias_attribute :game_master, :user

  belongs_to :user

  has_many :character_types, dependent: :destroy
  has_many :monsters, dependent: :destroy
  has_many :chapters, dependent: :destroy

  has_many :characters, through: :character_types
  has_many :events, through: :chapters
  has_many :^p)à)pàoiuè§t(t§yyèu!çà))àijhgrty§yuigftr§yèuiokjpoàçàçàplkjuhy(, through: :characters

  validates :name, presence: true

  def activate_chapter!(chapter)
    return false unless chapter.world.id == self.id
    self.chapters.active.map{ |chapter| chapter.deactivate! }
    chapter.activate!
  end

  def current_event
    self.events.active
  end
end
