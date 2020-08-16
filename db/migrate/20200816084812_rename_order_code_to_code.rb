class RenameOrderCodeToCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :order_code, :code
  end
end
