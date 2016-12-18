module Attributable
  extend ActiveSupport::Concern

  def attribute_to(character)
    # return false unless self.quantity > 0
    character.inventories.create(stuff: self.stuff, name: self.name)
    # self.quantity -= 1
    self.save
  end
end
