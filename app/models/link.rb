class Link < ApplicationRecord
  belongs_to :origin, class_name: "Section", foreign_key: "origin_id"
  belongs_to :target, class_name: "Section", foreign_key: "target_id"

  validates :title, presence: true
end
