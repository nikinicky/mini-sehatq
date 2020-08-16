class CreateDoctorSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_schedules do |t|
      t.integer :doctor_id, index: true
      t.integer :hospital_id, index: true
      t.date :date
      t.string :start_hour
      t.string :end_hour

      t.timestamps
    end
  end
end
