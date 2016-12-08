class EventMonster < ApplicationRecord
  include Combat
  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  belongs_to :monster
  belongs_to :event

  delegate :world, :to => :monster

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def current_life
    self.monster.life + self.bonus_life - self.malus_life
  end

  def life
    self.monster.life + self.bonus_life
  end

  def armor
    self.monster.armor + self.bonus_armor
  end

  def attack_min
    self.monster.attack_min + self.bonus_attack_min
  end

  def attack_max
    self.monster.attack_max + self.bonus_attack_max
  end
end
