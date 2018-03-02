class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.boolean :tc
      t.boolean :active
      t.string :paypal_oauth

      t.timestamps
    end
  end
end
