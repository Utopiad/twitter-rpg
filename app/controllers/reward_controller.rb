class RewardController < ApplicationController

  def new
    @stuff = Stuff.new
    @world_id = params[:world_id]
    @chapter_id = params[:chapter_id]
    @event_id = params[:event_id]
  end

  def create
    @stuff = Stuff.new(params.require(:stuff).permit(:name, :world_id, :bonus_attack, :bonus_armor, :bonus_life))

    if @stuff.save
      puts "oui"

      @reward = Reward.new(quantity: params[:quantity], event_id: params[:event_id], stuff_id: @stuff.id)

      if @reward.save
        if request.xhr?
          render :json => {
            :world_id => params[:world_id]
          }
        else
          redirect_to controller: :character_type, action: :new, world_id: params[:world_id]
        end
      else
        @errors = @character_type.errors
        render :new
      end

    else
      puts @stuff.errors.inspect
    end

  end
end
