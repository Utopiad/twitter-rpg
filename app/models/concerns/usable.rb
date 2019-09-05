# frozen_string_literal: true

module Usable
  extend ActiveSupport::Concern

  def use!
    self.used = 1
    save
  end

  def used?
    used == 1
  end
end
