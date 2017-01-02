class CharacterType < ApplicationRecord
  belongs_to :world, required: false
  has_many :characters, dependent: :destroy

  validates :name, presence: true
  validates :attack_min, presence: true
  validates :attack_max, presence: true
  validates :armor, presence: true
  validates :life, presence: true
end
