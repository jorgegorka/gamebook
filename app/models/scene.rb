class Scene < ApplicationRecord
  STATUS_DRAFT = "draft".freeze
  STATUS_EDITING = "editing".freeze
  STATUS_READY = "ready".freeze

  belongs_to :chapter, counter_cache: true

  has_many :inbound_links, dependent: :destroy, class_name: "Link", foreign_key: "origin_id"
  has_many :outbound_links, dependent: :destroy, class_name: "Link", foreign_key: "target_id"

  positioned on: :chapter

  enum :status, { draft: 0, editing: 1, ready: 2 }, prefix: true


  def any_links?
    inbound_links.any? || outbound_links.any?
  end
end
