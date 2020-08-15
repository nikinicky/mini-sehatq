class AddDoctorIdToDoctorInformations < ActiveRecord::Migration[6.0]
  def change
    add_reference :doctor_informations, :doctor, class_name: 'User', index: true
  end
end
