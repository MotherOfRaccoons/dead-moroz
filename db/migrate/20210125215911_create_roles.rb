class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name,        null: false, limit: 50
      t.text   :description, limit: 280
    end
  end
end
