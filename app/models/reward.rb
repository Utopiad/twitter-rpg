class Reward < ApplicationRecord
  belongs_to :stuff
  belongs_to :event
end
