class Book < ApplicationRecord
  STATUS_DRAFT = 'draft'.freeze
  STATUS_EDITING = 'editing'.freeze
  STATUS_READY = 'ready'.freeze
  STATUS_PUBLISHED = 'published'.freeze

  belongs_to :user

  has_many :chapters, dependent: :destroy

  enum status: { draft: 0, editing: 1, ready: 2, published: 3 }, prefix: true
end
