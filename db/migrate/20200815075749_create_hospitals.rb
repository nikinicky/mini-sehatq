class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.string :discrict, null: false
      t.string :address
      t.string :open_hours
      t.boolean :support_emergency, default: false
    end
  end
end
