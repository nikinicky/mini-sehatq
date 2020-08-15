class RenameColumnInHospitals < ActiveRecord::Migration[6.0]
  def change
    rename_column :hospitals, :discrict, :district
  end
end
