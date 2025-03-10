class ScenesController < ApplicationController
  before_action :find_chapter
  before_action :find_scene, only: %i[show edit update destroy]
  before_action :find_scenes, only: %i[show search]

  def show
  end

  def new
    @scene = @chapter.scenes.new
  end

  def create
    @scene = @chapter.scenes.create(scene_params)

    if @scene.persisted?
      redirect_to chapter_scene_path(@chapter, @scene), notice: t("scenes.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @scene.update(scene_params)

    if @scene.persisted?
      redirect_to chapter_scene_path(@chapter, @scene), notice: t("scenes.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @scene.destroy

    redirect_to book_chapter_path(@chapter, @chapter.book), notice: t("scenes.deleted")
  end

  def search
    @scenes.where('scenes.title ILIKE ?', "%#{search_name}%").order(title: :asc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_employees_path }
    end
  end

  private

    def scene_params
      params.require(:scene).permit(:title, :body, :notes, :status)
    end

    def find_chapter
      @chapter = Current.user.chapters.find params[:chapter_id]
    end

    def find_scene
      @scene = @chapter.scenes.find params[:id]
    end

    def find_scenes
      @scenes = @chapter.book.scenes
        .where.not(scenes: { id: @scene.inbound_links.pluck(:origin_id) })
        .order(title: :asc).pluck(:id, :title)
    end

    def search_name
      @search_name ||= ActiveRecord::Base.sanitize_sql_like params[:name]
    end
end
