module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :create_slug!
  end

  def create_slug!
    template = "@%s"
    self.slug = template % [self.name]
  end

end
