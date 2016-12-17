class Reward < ApplicationRecord
  include Attributable
  belongs_to :stuff
  belongs_to :event

  delegate :world, :to => :stuff
end
