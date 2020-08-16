class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :doctor_schedule, foreign_key: 'schedule_id'

  has_one :order

  THRESHOLD_TIME = 30
  THRESHOLD_USER_IN_A_DAY = 10

  def hospital
    doctor_schedule.hospital
  end
end
