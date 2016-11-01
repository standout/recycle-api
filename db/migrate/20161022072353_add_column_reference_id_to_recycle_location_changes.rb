class AddColumnReferenceIdToRecycleLocationChanges < ActiveRecord::Migration[5.0]
  def change
    add_column :recycle_location_changes, :reference_id, :int, null: false
  end
end
