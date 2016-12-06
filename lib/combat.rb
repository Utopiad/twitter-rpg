module Combat
  def fight(defender:)
    fight.save
    self.attack(defender, fight)
    if defender.life > 0
      defender.ripost(self, fight)
    end
  end

  def attack(target, fight)
    hit = rand(self.attack_min..self.attack_max)
    target.malus_life += (hit - target.armor) < 0 ? 0 : (hit - target.armor)
    fight.attacker_hit = hit
    fight.save
  end

  def ripost(target, fight)
    hit = rand(self.attack_min..self.attack_max)
    target.malus_life += (hit - target.armor) < 0 ? 0 : (hit - target.armor)
    fight.defender_hit = hit
    fight.save
  end
end
