module Narrator
  extend ActiveSupport::Concern

  included do
    before_save :create_slug!
  end

  def is_narrator?
    self.is_narrator == 1
  end

  def is_narrator!
    self.is_narrator = 1
    self.save
  end

  def is_not_narrator!
    self.is_narrator = 0
    self.save
  end

end
