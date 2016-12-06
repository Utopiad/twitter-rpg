class Monster < ApplicationRecord
  include Combat
  belongs_to :world
  has_many :fights, as: :attacker
  has_many :fights, as: :defender

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def current_life
    self.life - self.malus_life
  end
end
