class GameController < ApplicationController
  def index
    @world = World.where(id: params[:world_id]).first
    @messages = @world.messages

    puts "@world : #{@world.id}"
    puts "@messages"
    puts @messages
    puts @messages
    puts "@messages"

    if current_user == @world.game_master
      puts "game master"
    end
    if current_user.joined_worlds.pluck(:id).include?(@world.id)
      @character = current_user.character_for_world_id(@world.id).first
      # head 404 and return unless @world
      # @current_chapter = @world.chapters.active.first
      # head 404 and return unless @current_chapter
      # @current_event = @current_chapter.events.active.first
      # head 404 and return unless @current_event
      # puts "world events: #{@world.current_event}"
      puts "has a character in world"
      puts "he is named #{@character.name}"
    end
  end
end
