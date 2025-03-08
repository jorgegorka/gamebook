class User < ApplicationRecord
  ROLE_READER = "reader".freeze
  ROLE_EDITOR = "editor".freeze
  ROLE_ADMIN = "admin".freeze

  belongs_to :account

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum role: { reader: 0, editor: 1, admin: 9 }, prefix: true
end
