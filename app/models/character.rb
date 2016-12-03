class Character < ApplicationRecord
  belongs_to :classe
  belongs_to :world
  belongs_to :user
end
