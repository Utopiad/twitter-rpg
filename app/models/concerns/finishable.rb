module Finishable
  extend ActiveSupport::Concern

  def finish!
    self.finished = 1
    self.save
  end

  def is_finished?
    self.finished == 1
  end
end
