class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id, index: true
      t.integer :user_id, index: true
      t.integer :schedule_id, index: true

      t.timestamps
    end
  end
end
