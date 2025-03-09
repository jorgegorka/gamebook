class ChaptersController < ApplicationController
  before_action :find_book
  before_action :find_chapter, only: %i[show edit update destroy]

  def show
  end

  def new
    @chapter = @book.chapters.new
  end

  def create
    @chapter = @book.chapters.create chapter_params

    if @chapter.persisted?
      redirect_to book_chapter_path(@book, @chapter), notice: t('chapters.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @chapter.update chapter_params

    if @chapter.persisted?
      redirect_to book_chapter_path(@book, @chapter), notice: t('chapters.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chapter.destroy

    redirect_to book_path(@book), notice: t('chapters.deleted')
  end

  private

    def chapter_params
      params.require(:chapter).permit(:title, :summary, :status)
    end

    def find_book
      @book = Current.user.books.find params[:book_id]
    end

    def find_chapter
      @chapter = @book.chapters.find params[:id]
    end
end
