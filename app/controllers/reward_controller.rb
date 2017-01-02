class RewardController < ApplicationController

  def new
    @stuff = Stuff.new
    @world_id = params[:world_id]
    @chapter_id = params[:chapter_id]
    @event_id = params[:event_id]
  end

  def create
    @stuff = Stuff.new(params.require(:stuff).permit(:name, :world_id,
      :bonus_attack, :bonus_armor, :bonus_life))

    if @stuff.save
      @reward = Reward.new(quantity: params[:quantity],
        event_id: params[:event_id], stuff_id: @stuff.id)
      if @reward.save
        redirect_to controller: :character_type, action: :new,
          world_id: params[:world_id]
      else
        render :new
      end
    end
  end
end
