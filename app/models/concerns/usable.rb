module Usable
  extend ActiveSupport::Concern

  def use!
    self.used = 1
    self.save
  end

  def used?
    self.used == 1
  end
end
