class Monster < ApplicationRecord
  include Combat
  belongs_to :world
end
