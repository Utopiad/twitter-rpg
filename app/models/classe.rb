class Classe < ApplicationRecord
  belongs_to :world
  has_many :characters, dependent: :destroy
end
