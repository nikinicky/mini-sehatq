class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_code
      t.integer :appointment_id
      t.string :payment_type
      t.string :notes
      t.string :status

      t.timestamps
    end
  end
end
