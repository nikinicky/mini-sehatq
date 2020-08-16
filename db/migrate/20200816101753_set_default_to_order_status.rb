class SetDefaultToOrderStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :status, Order::PENDING
  end
end
