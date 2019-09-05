# frozen_string_literal: true

module Narrator
  extend ActiveSupport::Concern

  included do
    before_save :create_slug!
  end

  def is_narrator?
    is_narrator == 1
  end

  def is_narrator!
    self.is_narrator = 1
    save
  end

  def is_not_narrator!
    self.is_narrator = 0
    save
  end
end
