class GraphsController < ApplicationController

  def index
    @graph_name = Nodes::Create.call(find_book, find_chapter)
  end

  private
    
    def find_book
      @book = Current.user.books.find params[:book_id]
    end

    def find_chapter
      return unless params[:chapter_id].present?

      @chapter = @book.chapters.find params[:chapter_id]
    end
end
