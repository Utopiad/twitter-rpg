class ChapterController < ApplicationController
  def new
    @chapter = Chapter.new
    @world_id = params[:world_id]
  end

  def create
    @chapter = Chapter.new(params.require(:chapter).permit(:picture,
      :description, :world_id, :title))
    if @chapter.save
      redirect_to controller: "event", action: "new", :world_id => params[:world_id], :chapter_id => @chapter.id
    else
      render :new
    end
  end

  def show
    @chapter = Chapter.where(id: params[:id]).first
    head 404 and return unless @chapter
  end
end
