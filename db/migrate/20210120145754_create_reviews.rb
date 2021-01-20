class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :body,           null: false, limit: 280
      t.belongs_to :reviewee, null: false
      t.belongs_to :reviewer, null: true

      t.timestamps
    end

    add_foreign_key :reviews, :users, column: :reviewee_id
    add_foreign_key :reviews, :users, column: :reviewer_id
  end
end
