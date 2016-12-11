module Fighter
  extend ActiveSupport::Concern

  def malus_life=(malus_life)
    self[:malus_life] = malus_life
    self.save
  end

  def attack(target)
    if self.has_played?
      return false
    end

    hit = rand(self.attack_min..self.attack_max)
    target.malus_life += (hit - target.armor) < 0 ? 0 : (hit - target.armor)

    fight = Fight.create(attacker: self, target: target, hit: hit)
    fight.save
    self.has_played!
  end

  # def heal(target:, amount:)
  #   target.malus_life = target.malus_life - amount < 0 ? 0 : target.malus_life - amount
  # end
end
