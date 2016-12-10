module Equipable
  extend ActiveSupport::Concern

  def equip!
    self.equiped = 1
    self.save
  end

  def equiped?
    self.equiped == 1
  end
end
