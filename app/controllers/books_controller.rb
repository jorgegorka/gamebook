class BooksController < ApplicationController
  before_action :find_book, only: %i[show edit update destroy]

  def index
    @books = Current.user.books.order(updated_at: :desc)
  end

  def show
  end

  def new
    @book = Current.user.books.new
  end

  def create
    @book = Current.user.books.create(book_params)

    if @book.persisted?
      redirect_to book_path(@book), notice: t("books.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @book.update(book_params)

    if @book.persisted?
      redirect_to book_path(@book), notice: t("books.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy

    redirect_to books_path, notice: t("books.deleted")
  end

  private

    def book_params
      params.require(:book).permit(:title, :summary, :status, :remarks)
    end

    def find_book
      @book = Current.user.books.find params[:id]
    end
end
