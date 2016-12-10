class Stuff < ApplicationRecord
  belongs_to :world

  has_many :rewards, dependent: :destroy
  has_many :events, through: :rewards

  has_many :inventories, dependent: :destroy
  has_many :characters, through: :inventories

  scope :attack_min, -> { where("bonus_attack_min > ?", 0) }
end
