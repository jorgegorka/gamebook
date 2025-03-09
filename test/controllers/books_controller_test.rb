require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    sign_in admin
  end

  test "should get index" do
    get books_url

    assert_response :success
  end

  test "should get show" do
    get book_url(books(:one))

    assert_response :success
  end

  test "should get new" do
    get new_book_url

    assert_response :success
  end

  test "should get create" do
    params = { book: { title: "New Book", summary: "New Description", remarks: "New Remarks" } }
    post books_url params

    assert_response :redirect

    book = admin.books.last

    assert_equal "New Book", book.title
    assert_equal "New Description", book.summary
    assert_equal "New Remarks", book.remarks
    assert_equal Book::STATUS_DRAFT, book.status
  end

  test "should get edit" do
    get edit_book_url(books(:one))

    assert_response :success
  end

  test "should get update" do
    book = books(:one)
    put book_url(book), params: { book: { title: "Updated Title" } }

    assert_response :redirect

    book.reload
    assert_equal "Updated Title", book.title
  end

  test "should get destroy" do
    delete book_url(books(:one))

    assert_response :redirect
  end
end
