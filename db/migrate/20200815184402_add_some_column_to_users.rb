class AddSomeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :is_doctor, :boolean, default: false
  end
end
