# frozen_string_literal: true

class Fight < ApplicationRecord
  belongs_to :attacker, polymorphic: true
  belongs_to :defender, polymorphic: true

  def export(format)
    defender = fetch_fighter(:defender)
    attacker = fetch_fighter(:attacker)
    if format == :txt
      template = "%s à attaqué %s lui portant un coup à %i de degats qui ont
      étés reduits par son armure de %i. Il reste %i pv à %s et %i pv à
      %s"
      return format(template, self.attacker.name, defender.name, hit, defender.armor, attacker.current_life, self.attacker.name, defender.current_life, self.defender.name)
    end
  end

  def fetch_fighter(role)
    if role == :defender
      if defender_type == 'Character'
        Character.find(defender_id)
      elsif defender_type == 'EventMonster'
        EventMonster.find(defender_id)
      end
    elsif role == :attacker
      if attacker_type == 'Character'
        Character.find(attacker_id)
      elsif attacker_type == 'EventMonster'
        EventMonster.find(attacker_id)
      end
    end
  end
end
