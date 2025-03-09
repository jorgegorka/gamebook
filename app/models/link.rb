class Link < ApplicationRecord
  belongs_to :origin, class_name: "Scene", foreign_key: "origin_id"
  belongs_to :target, class_name: "Scene", foreign_key: "target_id"

  validates :title, presence: true
end
