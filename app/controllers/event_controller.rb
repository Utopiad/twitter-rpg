# frozen_string_literal: true

class EventController < ApplicationController
  def new
    @event = Event.new
    @world_id = params[:world_id]
    @chapter_id = params[:chapter_id]
  end

  def create
    @event = Event.new(params.require(:event).permit(:title, :description,
                                                     :picture, :chapter_id))

    world_id = params[:world_id]

    if @event.save
      redirect_to controller: :reward, action: :new, world_id: world_id,
                  chapter_id: params[:chapter_id], event_id: @event.id
    else
      puts @events.error.inspect
      render :new
    end
  end

  def show
    @event = Event.where(id: params[:id]).first
    head(404) && return unless event
  end
end
