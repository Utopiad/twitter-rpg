class ClasseController < ApplicationController
  def new
    @classe = Classe.new
  end

  def create
    @classe = Classe.new(params.require(:classe).permit(:name, :world_id,
      :attack_min, :attack_max, :armor, :life))

    world_id = cookies[:current_world_id]
    @classe.world = World.where(id: world_id).first
    if @classe.save
      redirect_to action: "show", id: @classe.id
    else
      render :new
    end
  end

  def show
    @classe = Classe.where(id: params[:id]).first
    head 404 and return unless @classe
  end
end
