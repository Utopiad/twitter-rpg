# frozen_string_literal: true

class Reward < ApplicationRecord
  include Attributable
  include Sluggable
  belongs_to :stuff
  belongs_to :event

  delegate :world, to: :stuff
  delegate :name, to: :stuff
  delegate :slug, to: :stuff
end
