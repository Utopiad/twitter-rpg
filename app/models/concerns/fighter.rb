# require 'pry'

module Fighter
  extend ActiveSupport::Concern

  def attack(target)
    # if self.has_played?
    #   return false
    # end

    hit = rand(self.attack_min..self.attack_max)

    if hit >= target.armor
      inc_malus_life = hit - target.armor

      target.malus_life += inc_malus_life
    end

    fight = Fight.new(attacker: self, defender: target, hit: hit)
    fight.save
    self.has_played!

    return fight
  end

  # def heal(target:, amount:)
  #   target.malus_life = target.malus_life - amount < 0 ? 0 : target.malus_life - amount
  # end
end
