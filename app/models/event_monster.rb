class EventMonster < ApplicationRecord
  include Fighter
  include Sluggable
  has_many :fights, as: :attacker
  has_many :fights, as: :defender
  belongs_to :monster
  belongs_to :event

  delegate :world, :to => :monster

  validates_uniqueness_of :name


  def current_life
    self.life - self.malus_life
  end

  def life
    self.monster.life + self.bonus_life
  end

  def armor
    self.monster.armor + self.bonus_armor
  end

  def attack_min
    self.monster.attack_min + self.bonus_attack
  end

  def attack_max
    self.monster.attack_max + self.bonus_attack
  end
end
