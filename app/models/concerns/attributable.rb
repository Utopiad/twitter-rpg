# frozen_string_literal: true

module Attributable
  extend ActiveSupport::Concern

  def attribute_to(character)
    # return false unless self.quantity > 0
    character.inventories.create(stuff: stuff, name: name)
    # self.quantity -= 1
    save
  end
end
