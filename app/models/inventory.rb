class Inventory < ApplicationRecord
  include Equipable
  include Usable

  belongs_to :stuff
  belongs_to :character

  delegate :world, :to => :stuff
  delegate :name, :to => :stuff
  delegate :slug, :to => :stuff
end
