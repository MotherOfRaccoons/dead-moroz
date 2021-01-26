class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string     :title,      null: false
      t.text       :description
      t.belongs_to :recipient,  null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :added_by,   foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
