class EventController < ApplicationController
  def new
    @event = Event.new
    @world_id = params[:world_id]
  end

  def create
    @event = Event.new(params.require(:event).permit(:title, :description, :picture, :chapter_id))
    if @event.save
      redirect_to controller: "character_type", action: "new", :world_id => params[:world_id]
    else
      render :new
    end
  end

  def show
    @event = Event.where(id: params[:id]).first
    head 404 and return unless event
  end
end
