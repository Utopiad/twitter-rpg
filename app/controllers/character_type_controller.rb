class CharacterTypeController < ApplicationController
  def new
    @errors = Array.new
    @character_type = CharacterType.new
  end

  def create
    @character_type = CharacterType.new(params.require(:character_type).permit(:name, :world_id,
      :attack_min, :attack_max, :armor, :life))

    world_id = params[:world_id]
    @character_type.world = World.where(id: world_id).first
    if @character_type.save
      redirect_to action: "show", id: @character_type.id
    else
      @errors = @character_type.errors
      render :new
    end
  end

  def show
    @character_type = CharacterType.where(id: params[:id]).first
    head 404 and return unless @character_type
  end
end
