class Fight < ApplicationRecord
  belongs_to :attacker, polymorphic: true
  belongs_to :defender, polymorphic: true

  after_create :save_attacker
  after_create :save_defender

  def save_attacker
    self[:attacker_attack_min] = self.attacker.attack_min
    self[:attacker_attack_max] = self.attacker.attack_max
    self[:attacker_armor] = self.attacker.armor
    self[:attacker_life] = self.attacker.life
    self[:attacker_malus_life] = self.attacker.malus_life

    self.save
  end

  def save_defender
    self[:defender_attack_min] = self.defender.attack_min
    self[:defender_attack_max] = self.defender.attack_max
    self[:defender_armor] = self.defender.armor
    self[:defender_life] = self.defender.life
    self[:defender_malus_life] = self.defender.malus_life

    self.save
  end
end
