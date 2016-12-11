class Fight < ApplicationRecord
  belongs_to :attacker, polymorphic: true
  belongs_to :defender, polymorphic: true


  def export(format)
    if format == :txt
      template = "%s à attaqué %s lui portant un coup à %i de degats qui ont
      étés reduits par son armure de %i. Il reste %i pv à %s et %i pv à
      %s"
      return template % [self.attacker.name, self.defender.name, hit,
        self.defender.armor, self.attacker.current_life, self.attacker.name,
        self.defender.current_life, self.defender.name]
    end
  end
end
