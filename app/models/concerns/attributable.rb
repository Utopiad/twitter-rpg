require "pry"

module Attributable
  extend ActiveSupport::Concern

  def attribute_to(character)
    binding.pry

    return false unless self.quantity > 0
    character.inventories.create(stuff: self.stuff)
    self.quantity -= 1
    self.save
  end
end
