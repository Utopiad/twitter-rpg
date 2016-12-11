module Sluggable
  extend ActiveSupport::Concern

  def slug
    return self.slug unless self.slug.blank?
    self.create_slug
    return self.slug
  end

  def create_slug
    template = "@%s"
    self.slug = template % [self.name]
    self.save
  end
end
