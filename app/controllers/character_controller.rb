# frozen_string_literal: true

class CharacterController < ApplicationController
  def new
    @character = Character.new

    @world = World.where(id: params[:world_id]).first
    head(404) && return unless @world

    @world_characters_type = @world.character_types.map { |c| [c.name, c.id] }
  end

  def create
    @world = World.where(id: params[:world_id]).first
    head(404) && return unless @world

    @character = Character.new(params.require(:character).permit(:name,
                                                                 :character_type_id, :user_id))

    @character.user = current_user
    @character.world = @world

    if @character.save
      redirect_to action: 'show', id: @character.id
    else
      @world_characters_type = @world.character_types.map { |c| [c.name, c.id] }
      render :new
    end
  end

  def show
    @character = Character.where(id: params[:id]).first
    head(404) && return unless @character
  end
end
