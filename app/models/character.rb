class Character < ApplicationRecord
  include Combat
  belongs_to :user
  belongs_to :character_type
  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  has_many :messages
  has_many :inventories, dependent: :destroy
  has_many :stuffs, through: :inventories

  delegate :world, :to => :character_type

  def has_played?
    self.has_played == 1
  end

  def has_played!
    self.has_played = 1
  end

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def current_life
    self.character_type.life + self.bonus_life - self.malus_life
  end

  def life
    self.character_type.life + self.bonus_life
  end

  def armor
    self.character_type.armor + self.bonus_armor
  end

  def attack_min
    self.character_type.attack_min + self.bonus_attack_min
  end

  def attack_max
    self.character_type.attack_max + self.bonus_attack_max
  end
end
