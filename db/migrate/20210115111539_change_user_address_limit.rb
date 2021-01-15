class ChangeUserAddressLimit < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :users do |t|
        dir.up   { t.change :address, :string, limit: 100 }
        dir.down { t.change :address, :string, limit: 50 }
      end
    end
  end
end
