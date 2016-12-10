class Fight < ApplicationRecord
  belongs_to :attacker, polymorphic: true
  belongs_to :defender, polymorphic: true
end
