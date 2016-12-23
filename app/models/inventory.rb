class Inventory < ApplicationRecord
  include Equipable
  include Usable
  include Sluggable

  before_save :inherit_slug_and_name

  def inherit_slug_and_name
    self.name = self.stuff.name
    self.slug = self.stuff.slug
  end

  belongs_to :stuff
  belongs_to :character

  delegate :world, :to => :stuff
  delegate :name, :to => :stuff
  delegate :slug, :to => :stuff
end
