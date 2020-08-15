class CreateDoctorInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_informations do |t|
      t.string :description
      t.integer :hospital_ids, array: true, default: []
      t.integer :speciality_id

      t.timestamps
    end
  end
end
