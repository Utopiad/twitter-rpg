# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :character
  belongs_to :event

  delegate :world, to: :event
end
