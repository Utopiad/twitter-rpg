class World < ApplicationRecord
  alias_attribute :game_master, :user

  belongs_to :user

  has_many :character_type, dependent: :destroy
  # has_many :characters, dependent: :destroy
  has_many :monsters, dependent: :destroy
  # has_many :chapters, dependent: :destroy
  # has_many :events, through: :chapters
  # has_many :messages

  validates :name, presence: true
end
