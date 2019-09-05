# frozen_string_literal: true

module Player
  extend ActiveSupport::Concern

  def has_played?
    has_played == 1
  end

  def has_played!
    self.has_played = 1
    save
  end

  def has_not_played!
    self.has_played = 0
    save
  end
end
