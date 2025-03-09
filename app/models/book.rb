class Book < ApplicationRecord
  STATUS_DRAFT = "draft".freeze
  STATUS_EDITING = "editing".freeze
  STATUS_READY = "ready".freeze
  STATUS_PUBLISHED = "published".freeze

  belongs_to :user

  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 400, 400 ]
  end

  has_many :chapters, dependent: :destroy

  enum :status, { draft: 0, editing: 1, ready: 2, published: 3 }, prefix: true

  validates :title, presence: true
end
