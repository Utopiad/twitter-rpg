# frozen_string_literal: true

module Activable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where('active = ?', 1).first }
  end

  def activate!
    self.active = 1
    save
  end

  def deactivate!
    self.active = 0
    save
  end

  def active?
    active == 1
  end
end
