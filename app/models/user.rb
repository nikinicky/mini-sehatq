class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :doctor_information, foreign_key: 'doctor_id'

  has_many :user_tokens
  has_many :appointments
  has_many :doctor_schedules, foreign_key: 'doctor_id'
  has_many :doctors, class_name: 'User', foreign_key: 'doctor_id', through: :appointments
  has_many :users, class_name: 'User', foreign_key: 'user_id', through: :appointments

  validates_presence_of :full_name
  validates_presence_of :email

  validates_uniqueness_of :email

  validates :full_name, length: { minimum: 3, maximum: 51 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  def speciality_name
    doctor_information.speciality.name if is_doctor
  end

  def schedules
    doctor_schedules if is_doctor
  end

  def age
    return nil if birthday.nil?
    age = Date.today.year - birthday.year
  end
end
