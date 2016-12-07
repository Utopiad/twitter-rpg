class Chapter < ApplicationRecord
  belongs_to :world
  has_many :chapters, dependent: :destroy
end
