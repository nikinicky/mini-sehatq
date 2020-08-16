class Hospital < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :district

  belongs_to :hospital_type
  has_many :doctor_schedules

  def type_name
    hospital_type&.name || "Rumah Sakit"
  end
end
