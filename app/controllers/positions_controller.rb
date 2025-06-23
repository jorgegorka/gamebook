class PositionsController < ApplicationController
  def update
    scene = Scene.find(params[:id])
    if params[:move] == "up"
      scene.move_higher
    else
      scene.move_lower
    end

    chapter = scene.chapter

    redirect_to book_chapter_path(chapter.book_id, chapter)
  end
end
