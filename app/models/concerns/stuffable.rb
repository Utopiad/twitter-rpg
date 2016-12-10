module Stuffable
  extend ActiveSupport::Concern

  def equiped_stuffs
    self.inventories.where("equiped = ?", 1)
      .find_all.map{ |i| i.stuff }
  end

  def attack_stuffs_bonus
    self.equiped_stuffs.map{ |s| s.bonus_attack }.sum
  end
  def armor_stuffs_bonus
    self.equiped_stuffs.map{ |s| s.bonus_armor }.sum
  end
  def life_stuffs_bonus
    self.equiped_stuffs.map{ |s| s.life }.sum
  end
end
