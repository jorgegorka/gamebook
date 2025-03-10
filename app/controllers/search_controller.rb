class SearchController < ApplicationController
  before_action :find_book
  def create
    @scenes = @book.scenes.where('scenes.title LIKE ?', "%#{search_name}%").order(title: :asc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_employees_path }
    end
  end

  private

    def find_book
      @book = Current.user.books.find params[:source]
    end

    def search_name
      @search_name ||= ActiveRecord::Base.sanitize_sql_like params[:name]
    end
end
