class Character < ApplicationRecord
  belongs_to :user
  belongs_to :world
  belongs_to :classe
  has_many :fights, as: :attacker
  has_many :fights, as: :defender

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def life
    self.classe.life + self.bonus_life - self.malus_life
  end

  def armor
    self.classe.armor + self.bonus_armor
  end

  def attack_min
    self.classe.attack_min + self.bonus_attack_min
  end

  def attack_max
    self.classe.attack_max + self.bonus_attack_max
  end
end
