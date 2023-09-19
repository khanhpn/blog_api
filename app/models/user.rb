class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_secure_password
end
