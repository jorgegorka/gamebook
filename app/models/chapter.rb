class Chapter < ApplicationRecord
  STATUS_DRAFT = 'draft'.freeze
  STATUS_EDITING = 'editing'.freeze
  STATUS_READY = 'ready'.freeze

  belongs_to :book, counter_cache: true

  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 400, 400 ]
  end

  has_many :scenes, dependent: :destroy

  enum :status, { draft: 0, editing: 1, ready: 2 }, prefix: true
end
