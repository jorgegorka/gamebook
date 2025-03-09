module BooksHelper
  def book_statuses_for_select
    [
      [ Book::STATUS_DRAFT, t("books.status.draft") ],
      [ Book::STATUS_EDITING,t( "books.status.editing") ],
      [ Book::STATUS_READY, t("books.status.ready") ],
      [ Book::STATUS_PUBLISHED, t("books.status.published") ]
    ]
  end
end
