class WorldController < ApplicationController
  def show
    @world = World.where(id: params[:id]).first
    @messages = @world.messages
    head 404 and return unless @world
  end

  def new
    unless user_signed_in?
      redirect_to controller: "devise/sessions", action: "new"
    end
    @world = World.new
  end

  def create
    @world = World.new(params.require(:world).permit(:name, :public))
    @world.user = current_user
    if @world.save
      cookies[:current_world_id] = @world.id
      redirect_to action: "show", id: @world.id
    else
      render :new
    end
  end

  def edit
    world = World.where(id: params[:id]).first
    unless user_signed_in? && current_user.id == world.user.id
      redirect_to action: "show", id: world.id
    end
    @world = world
  end

  def update
    world = World.where(id: params[:id]).first
    if world.update(params.require(:world).permit(:name, :public))
      redirect_to action: "show", id: world.id
    else
      render :edit
    end
  end
end
