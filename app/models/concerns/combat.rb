module Combat
  extend ActiveSupport::Concern

  def fight(defender:)
    fight = Fight.new(attacker: self, defender: defender)
    fight.save
    self.attack(defender, fight)
    if defender.current_life > 0
      defender.ripost(self)
    end
  end

  def attack(defender, fight)
    hit = rand(self.attack_min..self.attack_max)
    defender.malus_life += (hit - defender.armor) < 0 ? 0 : (hit - defender.armor)
    fight.hit = hit
    fight.save
  end

  def ripost(defender)
    fight = Fight.new(attacker: self, defender: defender)

    hit = rand(self.attack_min..self.attack_max)
    defender.malus_life += (hit - defender.armor) < 0 ? 0 : (hit - defender.armor)
    fight.hit = hit
    fight.save
  end

  # def heal(target:, amount:)
  #   target.malus_life = target.malus_life - amount < 0 ? 0 : target.malus_life - amount
  # end
end
