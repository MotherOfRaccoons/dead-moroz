class ChangeGiftAddedByConstraint < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :gifts do |t|
        dir.up   { t.change :added_by_id, :integer, null: true }
        dir.down { t.change :added_by_id, :integer, null: false }
      end
    end
  end
end
