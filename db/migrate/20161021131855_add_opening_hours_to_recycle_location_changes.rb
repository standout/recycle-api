class AddOpeningHoursToRecycleLocationChanges < ActiveRecord::Migration[5.0]
  def change
    add_column :recycle_location_changes, :opening_hours, :text, null: false, array: true, default: Array.new(7)
  end
end
