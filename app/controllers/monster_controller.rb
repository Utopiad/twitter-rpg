class MonsterController < ApplicationController
  def new
    @monster = Monster.new
  end

  def create
    @monster = Monster.new(params.require(:monster).permit(:name,
      :attack_min, :attack_max, :armor, :life))

    world_id = params[:world_id]

    @monster.world = World.where(id: world_id).first

    if @monster.save
      redirect_to action: "show", id: @monster.id
    else
      render :new
    end
  end

  def show
    @monster = Monster.where(id: params[:id]).first
    head 404 and return unless @monster
  end
end
