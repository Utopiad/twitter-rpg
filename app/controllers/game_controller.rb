class GameController < ApplicationController
  def index
    @world = World.where(id: params[:world_id]).first
    head 404 and return unless @world
    @current_chapter = @world.current_chapter
    @current_event = @world.current_event
    @messages = @world.messages.order(created_at: :asc)

    if current_user == @world.game_master
      cookies.signed[:current_user_id] = current_user.id
      puts "game master"
    end

    if current_user.joined_worlds.pluck(:id).include?(@world.id)
      cookies.signed[:current_user_id] = current_user.id

      @character = current_user.character_for_world_id(@world.id)
      @character_stuffs = @character.stuffs
      @character_type = CharacterType.where(
        id: @character.character_type_id,
        world_id: @world.id
        ).first
      @full_life = @character.life + @character.bonus_life

    end
  end

  def activate_chapter
    world = World.where(id: params[:world_id]).first

    chapter = world.chapters.where(id: params[:chapter_id]).first
    world.activate_chapter!(chapter)
    @current_chapter = chapter

    redirect_to action: :index, world_id: params[:world_id]
  end

  def activate_event
    world = World.where(id: params[:world_id]).first
    messages = world.messages.order(created_at: :asc)

    event = world.events.where(id: params[:event_id]).first
    world.activate_event!(event)
    @current_event = event

    redirect_to action: :index, world_id: params[:world_id]
  end
end
