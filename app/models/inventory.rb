class Inventory < ApplicationRecord
  belongs_to :stuff
  belongs_to :character
  scope :default, -> { where(:equiped == 1) }
end
