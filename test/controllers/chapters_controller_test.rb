require "test_helper"

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in admin
  end

  test "should get show" do
    get book_chapter_url(book, chapter)

    assert_response :success
  end

  test "should get new" do
    get new_book_chapter_url(book)

    assert_response :success
  end

  test "should get create" do
    params = { chapter: { title: "New Chapter", summary: "Chapter Description" } }
    post book_chapters_url(book), params: params

    assert_response :redirect

    chapter = book.chapters.last

    assert_equal "New Chapter", chapter.title
    assert_equal "Chapter Description", chapter.summary
    assert_equal Book::STATUS_DRAFT, chapter.status
  end

  test "should get edit" do
    get edit_book_url(book, chapter)

    assert_response :success
  end

  test "should get update" do
    put book_chapter_url(book, chapter), params: { chapter: { title: "Updated Title" } }

    assert_response :redirect

    chapter.reload

    assert_equal "Updated Title", chapter.title
  end

  test "should get destroy" do
    assert_difference("book.chapters.count", -1) do
      delete book_chapter_url(book, chapter)
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
end
