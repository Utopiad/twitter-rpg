class Message < ApplicationRecord
  belongs_to :character
  # belongs_to :world

  belongs_to :turn
end
