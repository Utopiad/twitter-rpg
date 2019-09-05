# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :create_slug!
  end

  def create_slug!
    template = '@%s'
    self.slug = format(template, name)
  end
end
