class World < ApplicationRecord
  belongs_to :user
  has_many :classes, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :monsters, dependent: :destroy
  has_many :messages

  validates :name, presence: true

end
