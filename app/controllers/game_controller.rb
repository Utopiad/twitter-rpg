class GameController < ApplicationController
  def index
    @world = World.where(id: params[:world_id]).first
    cookies.signed[:current_user_id] = current_user.id
    @messages = @world.messages

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

  def activate_chapter
    world = World.where(id: params[:world_id]).first
    chapter = world.chapters.where(id: params[:chapter_id]).first

    world.activate_chapter!(chapter)
  end

  def activate_event
    world = World.where(id: params[:world_id]).first
    event = world.events.where(id: params[:event_id]).first

    world.activate_event!(event)
  end
end
