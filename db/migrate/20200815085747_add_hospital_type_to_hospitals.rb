class AddHospitalTypeToHospitals < ActiveRecord::Migration[6.0]
  def change
    add_reference :hospitals, :hospital_type, index: true
    add_timestamps :hospitals, default: Time.now
  end
end
