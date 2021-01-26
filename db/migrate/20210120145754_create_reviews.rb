class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text       :body,     null: false, limit: 280
      t.belongs_to :reviewee, null: false, foreign_key: { to_table: 'users' }
      t.belongs_to :reviewer, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
