class CharacterController < ApplicationController
  def new
    @character = Character.new
  end

  def create
    @character = Character.new(params.require(:character).permit(:name, :world_id,
      :classe_id, :user_id, :total_experience, :bonus_attack_min,
      :bonus_attack_max, :bonus_armor, :bonus_life))

    world_id = cookies[:current_world_id]
    current_user_id = current_user.id

    @character.world = World.where(id: world_id).first
    @character.user = User.where(id: current_user_id).first

    if @character.save
      redirect_to action: "show", id: @character.id
    else
      render :new
    end
  end

  def show
    @character = Character.where(id: params[:id]).first
    head 404 and return unless @character
  end
end
