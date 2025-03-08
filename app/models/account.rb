class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  kas_many :books, through: :users
end
