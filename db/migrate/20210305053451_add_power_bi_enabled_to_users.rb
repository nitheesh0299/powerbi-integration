class AddPowerBiEnabledToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :powerBI_enabled, :string
    add_column :users, :powerBI_user, :string
    add_column :users, :powerBI_password, :string
  end
end
