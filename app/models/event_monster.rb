# frozen_string_literal: true

class EventMonster < ApplicationRecord
  include Fighter
  include Player
  include Sluggable
  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  belongs_to :monster
  belongs_to :event

  delegate :world, to: :monster
  delegate :name, to: :monster
  delegate :slug, to: :monster

  validates_uniqueness_of :name

  def current_life
    life - malus_life
  end

  def life
    monster.life + bonus_life
  end

  def armor
    monster.armor + bonus_armor
  end

  def attack_min
    monster.attack_min + bonus_attack
  end

  def attack_max
    monster.attack_max + bonus_attack
  end
end
