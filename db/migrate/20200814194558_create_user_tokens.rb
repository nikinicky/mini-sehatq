class CreateUserTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tokens do |t|
      t.string :token, null: false
      t.integer :expires_in, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
