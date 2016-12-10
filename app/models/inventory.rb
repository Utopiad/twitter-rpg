class Inventory < ApplicationRecord
  belongs_to :stuff
  belongs_to :character

  delegate :world, :to => :stuff

  scope :default, -> { where("equiped = ?", 1) }
end
