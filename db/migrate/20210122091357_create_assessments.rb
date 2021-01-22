class CreateAssessments < ActiveRecord::Migration[6.1]
  def change
    create_table :assessments do |t|
      t.integer :value,     null: false, limit: 1
      t.text :comment,      null: true, limit: 280
      t.belongs_to :author, null: true
      t.belongs_to :target, null: false

      t.timestamps
    end

    add_foreign_key :assessments, :users, column: :author_id
    add_foreign_key :assessments, :users, column: :target_id
    add_index :assessments, [:author_id, :target_id], unique: true
  end
end
