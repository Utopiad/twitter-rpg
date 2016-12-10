module Activable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where("active = ?", 1) }
  end

  def activate!
    self.active = 1
    self.save
  end

  def deactivate!
    self.active = 0
    self.save
  end

  def active?
    self.active == 1
  end
end
