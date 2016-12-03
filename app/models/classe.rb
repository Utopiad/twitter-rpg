class Classe < ApplicationRecord
  belongs_to :world
  has_many :character
end
