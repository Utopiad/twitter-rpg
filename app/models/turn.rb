class Turn < ApplicationRecord
  include Finishable
  belongs_to :event

  delegate :world, :to => :event
end
