class HomeController < ApplicationController

  def index
    if current_user.worlds.count > 0
      @user_worlds = current_user.worlds
    end

    if current_user.joined_worlds.count > 0
      @joined_worlds = current_user.joined_worlds

    end
  end
end
