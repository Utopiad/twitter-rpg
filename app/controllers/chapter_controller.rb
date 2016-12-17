class ChapterController < ApplicationController
  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(params.require(:chapter).permit(:picture,
      :description, :world_id, :title))
    if @chapter.save
      redirect_to action: "show", id: @chapter.id
    else
      render :new
    end
  end

  def show
    @chapter = Chapter.where(id: params[:id]).first
    head 404 and return unless @chapter
  end
end
