class Turn < ApplicationRecord
  belongs_to :event

  delegate :world, :to => :event
end
