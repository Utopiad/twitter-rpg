module Player
  extend ActiveSupport::Concern

  def has_played?
    self.has_played == 1
  end

  def has_played!
    self.has_played = 1
    self.save
  end

  def has_not_played!
    self.has_played = 0
    self.save
  end
end
