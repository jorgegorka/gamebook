module BooksHelper
  def book_statuses_for_select
    [
      [ Book::STATUS_DRAFT, "Draft" ],
      [ Book::STATUS_EDITING, "Editing" ],
      [ Book::STATUS_READY, "Ready" ],
      [ Book::STATUS_PUBLISHED, "Published" ]
    ]
  end
end
