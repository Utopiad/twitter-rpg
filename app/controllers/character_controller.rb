class CharacterController < ApplicationController
  def new
    @character = Character.new
  end

  def create
    @character = Character.new(params.require(:character).permit(:name, :world_id,
      :character_type_id, :user_id))

    @character.user = current_user

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
