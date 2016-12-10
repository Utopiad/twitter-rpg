class Reward < ApplicationRecord
  belongs_to :stuff
  belongs_to :event

  delegate :world, :to => :stuff

  def attribute_to(character)
    character.inventories.create(stuff: self.stuff)
  end
end
