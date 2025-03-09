require "test_helper"

class ScenesControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in admin
  end

  test "should get show" do
    get chapter_scene_url(chapter, scene)

    assert_response :success
  end

  test "should get new" do
    get new_chapter_scene_url(chapter)

    assert_response :success
  end

  test "should get create" do
    params = { scene: { body: "New Scene", notes: "Scene Description" } }
    post chapter_scenes_url(book), params: params

    assert_response :redirect

    scene = chapter.scenes.last

    assert_equal "New Scene", scene.body
    assert_equal "Scene Description", scene.notes
    assert_equal Scene::STATUS_DRAFT, scene.status
  end

  test "should get edit" do
    get edit_chapter_scene_url(chapter, scene)

    assert_response :success
  end

  test "should get update" do
    put chapter_scene_url(chapter, scene), params: { scene: { body: "Updated body" } }

    assert_response :redirect

    scene.reload

    assert_equal "Updated body", scene.body
  end

  test "should get destroy" do
    assert_difference("chapter.scenes.count", -1) do
      delete chapter_scene_url(chapter, scene)
    end

    assert_response :redirect
  end

  private

    def book
      @book ||= books(:one)
    end

    def chapter
      @chapter ||= book.chapters.first
    end

    def scene
      @scene ||= chapter.scenes.first
    end
end
