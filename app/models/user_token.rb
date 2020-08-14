class UserToken < ApplicationRecord
  belongs_to :user

  validates_presence_of :token
  validates_presence_of :expires_in
  validates_presence_of :user_id
end
