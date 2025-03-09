class Scene < ApplicationRecord
  STATUS_DRAFT = "draft".freeze
  STATUS_EDITING = "editing".freeze
  STATUS_READY = "ready".freeze

  belongs_to :chapter

  positioned on: :chapter

  enum :status, { draft: 0, editing: 1, ready: 2 }, prefix: true
end
