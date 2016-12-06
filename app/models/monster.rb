class Monster < ApplicationRecord
  include Combat
  belongs_to :world
  has_many :fights, as: :attacker
  has_many :fights, as: :defender

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def life
    self.life - self.malus_life
  end

  def armor
    self.armor
  end

  def attack_min
    self.attack_min
  end

  def attack_max
    self.attack_max
  end
end
