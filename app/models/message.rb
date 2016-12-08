class Message < ApplicationRecord
  belongs_to :character
  belongs_to :world
  belongs_to :event
end
