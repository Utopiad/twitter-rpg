# frozen_string_literal: true

class WorldController < ApplicationController
  def show
    @world = World.where(id: params[:id]).first
    head(404) && return unless @world
    @user_owner = User.where(id: @world.user_id).first
    @event = @world.current_event
  end

  def new
    unless user_signed_in?
      redirect_to controller: 'devise/sessions', action: 'new'
    end
    @world = World.new
  end

  def create
    # @world = World.new(params.require(:world).permit(:name, :public))
    name = params[:world][:name]
    public = params[:world][:public]
    @world = World.new(name: name, public: public)
    @world.user = current_user
    if @world.save
      narrator = CharacterType.find(1).characters.create(name: params[:world][:narrator_name],
                                                         user: current_user, world: @world)
      puts narrator.errors.inspect
      @world.narrator = narrator
      redirect_to controller: 'chapter', action: 'new', world_id: @world.id
    else
      render :new
    end
  end

  def edit
    world = World.where(id: params[:id]).first
    unless user_signed_in? && current_user.id == world.user.id
      redirect_to action: 'show', id: world.id
    end
    @world = world
  end

  def update
    world = World.where(id: params[:id]).first
    if world.update(params.require(:world).permit(:name, :image, :public))
      redirect_to action: 'show', id: world.id
    else
      render :edit
    end
  end

  def index
    @worlds = World.public_worlds
    @worlds = if params[:search]
                World.search(params[:search])
              else
                World.public_worlds
              end
  end
end
