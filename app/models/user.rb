class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :user_tokens

  validates_presence_of :full_name
  validates_presence_of :email

  validates_uniqueness_of :email

  validates :full_name, length: { minimum: 3, maximum: 51 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
