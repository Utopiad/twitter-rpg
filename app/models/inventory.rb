class Inventory < ApplicationRecord
  include Equipable
  include Usable
  include Sluggable

  belongs_to :stuff
  belongs_to :character

  delegate :world, :to => :stuff
end
