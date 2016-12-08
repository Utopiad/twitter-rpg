class Character < ApplicationRecord
  include Combat
  belongs_to :user
  belongs_to :world
  belongs_to :classe
  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  has_many :messages
  has_many :inventories, dependent: :destroy
  has_many :stuffs, through: :inventories


  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def current_life
    self.classe.life + self.bonus_life - self.malus_life
  end

  def life
    self.classe.life + self.bonus_life
  end

  def armor
    self.classe.armor + self.bonus_armor + self.stuffs.armor.first
  end

  def attack_min
    self.classe.attack_min + self.bonus_attack_min + self.stuffs.attack_min.first
  end

  def attack_max
    self.classe.attack_max + self.bonus_attack_max + self.stuffs.attack_max.first
  end
end
