require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in admin
  end

  test "should get create" do
    params = { link: { origin_id: scene.id, title: "Go here, please", notes: "Scene Description", target_id: other_scene.id } }
    post links_url(scene), params: params

    assert_response :redirect

    link = scene.inbound_links.last

    assert_equal "Go here, please", link.title
    assert_equal "Scene Description", link.notes
    assert_equal scene, link.origin
    assert_equal other_scene, link.target
  end

  test "should get update" do
    put link_url(link), params: { link: { origin_id: scene.id, title: "Updated title", target_id: scenes(:scene_c).id } }

    assert_response :redirect

    link.reload

    assert_equal "Updated title", link.title
    assert_equal scenes(:scene_c), link.target
  end

  test "should get destroy" do
    assert_difference("scene.inbound_links.count", -1) do
      delete link_url(link)
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

    def other_scene
      @other_scene ||= scenes(:scene_b)
    end

    def link
      @link ||= scene.inbound_links.first
    end
end
