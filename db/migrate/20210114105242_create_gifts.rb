class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string :title, null: false
      t.text :description
      t.belongs_to :recipient, null: false
      t.belongs_to :added_by, null: true

      t.timestamps
    end

    add_foreign_key :gifts, :users, column: :recipient_id
    add_foreign_key :gifts, :users, column: :added_by_id
  end
end
