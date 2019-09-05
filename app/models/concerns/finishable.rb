# frozen_string_literal: true

module Finishable
  extend ActiveSupport::Concern

  def finish!
    self.finished = 1
    save
  end

  def is_finished?
    finished == 1
  end
end
