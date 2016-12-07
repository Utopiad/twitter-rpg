class World < ApplicationRecord
  belongs_to :user
  has_many :classes, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :monsters, dependent: :destroy
  has_many :chapters, dependent: :destroy
  has_many :events, through: :chapters

  validates :name, presence: true

end
