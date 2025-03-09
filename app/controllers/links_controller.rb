class LinksController < ApplicationController
  before_action :find_link, only: %i[update destroy]
  before_action :check_target, only: %i[create update]

  def create
    scene = Scene.find link_params[:origin_id]
    Current.user.chapters.find scene.chapter_id
    @link = scene.inbound_links.create(link_params)

    if @link.persisted?
      redirect_to chapter_scene_path(scene.chapter, scene), notice: t("link.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @link.update(link_params)

    if @link.persisted?
      redirect_to chapter_scene_path(@scene.chapter, @scene), notice: t("link.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy

    redirect_to chapter_scene_path(@scene.chapter, @scene), notice: t("link.deleted")
  end

  private

    def link_params
      params.require(:link).permit(:title, :notes, :origin_id, :target_id)
    end

    def find_origin
      @scene = Scene.find link_params[:origin_id]
      Current.user.chapters.find scene.chapter_id
    end

    def find_link
      @link = Link.find params[:id]
      @scene = @link.origin
      Current.user.chapters.find @scene.chapter_id
    end

    def check_target
      return if link_params[:target_id].blank?

      target = Scene.find link_params[:target_id]
      Current.user.chapters.find target.chapter_id
    end
end
