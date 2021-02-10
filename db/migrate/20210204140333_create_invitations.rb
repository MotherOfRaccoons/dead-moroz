class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string  :token
      t.integer :status, null: false, limit: 1, default: 0
      t.string  :email,  null: false

      t.timestamps
    end
    add_index :invitations, :token, unique: true
    add_index :invitations, :email, unique: true
  end
end
