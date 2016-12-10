class Reward < ApplicationRecord
  belongs_to :stuff
  belongs_to :event

  delegate :world, :to => :stuff
end
