# frozen_string_literal: true

module Stuffable
  extend ActiveSupport::Concern

  def equiped_stuffs
    inventories.where('equiped = ?', 1)
               .find_all.map(&:stuff)
  end

  def attack_stuffs_bonus
    equiped_stuffs.map(&:bonus_attack).sum
  end

  def armor_stuffs_bonus
    equiped_stuffs.map(&:bonus_armor).sum
  end

  def life_stuffs_bonus
    equiped_stuffs.map(&:bonus_life).sum
  end
end
