class Inventory < ApplicationRecord
  include Equipable
  include Usable

  belongs_to :stuff
  belongs_to :character

  delegate :world, :to => :stuff

  scope :default, -> { where("equiped = ?", 1) }
end
