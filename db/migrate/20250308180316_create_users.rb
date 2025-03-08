class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.references :account, null: false, foreign_key: true
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 0

      t.timestamps
    end
    add_index :users, %i[account_id email_address], unique: true
  end
end
