class DoctorInformation < ApplicationRecord
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :doctor_speciality, foreign_key: 'speciality_id'

  def speciality
    doctor_speciality
  end

  def hospitals
    Hospital.where(id: hospital_ids)
  end

  def district
    hospitals&.first&.district || ""
  end
end
