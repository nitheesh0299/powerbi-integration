class CreatePowerbiUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :powerbi_users, id=> false do |t| 
      t.string :company_name
      t.string :username
      t.string :email
      t.string :hashed_password
      t.integer :firm_id
      t.string :role
      t.string :group_id
    end
  end
end
