class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :books, through: :users
end
