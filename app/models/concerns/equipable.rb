# frozen_string_literal: true

module Equipable
  extend ActiveSupport::Concern

  def equip!
    self.equiped = 1
    save
  end

  def equiped?
    equiped == 1
  end
end
