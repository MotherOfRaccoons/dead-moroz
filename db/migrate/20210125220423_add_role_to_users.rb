class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, limit: 1, null: false, default: 0
  end
end
