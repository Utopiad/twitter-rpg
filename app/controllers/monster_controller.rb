class MonsterController < ApplicationController
  def new
    @monster = Monster.new
    @world_id = params[:world_id]
  end

  def create
    @monster = Monster.new(params.require(:monster).permit(:name,
      :attack_min, :attack_max, :armor, :life))

    world_id = params[:world_id]

    @monster.world = World.where(id: world_id).first

    if @monster.save
      if request.xhr?
        render :json => {
          :world_id => params[:world_id]
        }
      else
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def show
    @monster = Monster.where(id: params[:id]).first
    head 404 and return unless @monster
  end
end
