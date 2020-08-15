class CreateDoctorSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_specialities do |t|
      t.string :name
      t.timestamps
    end
  end
end
