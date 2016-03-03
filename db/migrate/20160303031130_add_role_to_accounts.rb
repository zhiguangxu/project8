class AddRoleToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :role, :integer
  end
end
