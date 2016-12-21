class Reward < ApplicationRecord
  include Attributable
  belongs_to :stuff
  belongs_to :event

  delegate :world, :to => :stuff
  delegate :name, :to => :stuff
  delegate :slug, :to => :stuff
end
