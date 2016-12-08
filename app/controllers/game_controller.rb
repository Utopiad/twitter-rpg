class GameController < ApplicationController
  def index
    @world = World.where(id: params[:world_id]).first
    puts "@world : #{@world.id}"
    puts "curr user world : #{current_user.joined_worlds_id}"
    head 404 and return unless @world
    if current_user = @world.game_master
      puts "game master"
    end
    if current_user.joined_world_id?(@world.id)
      puts "world events: #{@world.current_event}"
      puts "has a character in world"
    end
  end
end
