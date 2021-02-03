class AddCompanyIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :companyId, :integer
  end
end
