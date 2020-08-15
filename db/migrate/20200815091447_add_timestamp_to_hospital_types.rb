class AddTimestampToHospitalTypes < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :hospital_types, default: Time.now
  end
end
