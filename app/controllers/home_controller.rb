# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user_worlds = current_user.worlds if current_user.worlds.count > 0

    if current_user.joined_worlds.count > 0
      @joined_worlds = current_user.joined_worlds

    end
  end
end
