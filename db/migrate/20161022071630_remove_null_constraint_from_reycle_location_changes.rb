class RemoveNullConstraintFromReycleLocationChanges < ActiveRecord::Migration[5.0]
  def change
    change_column_null :recycle_location_changes, :name, true
    change_column_null :recycle_location_changes, :kind,  true
    change_column_null :recycle_location_changes, :materials, true
    change_column_null :recycle_location_changes, :latitude, true
    change_column_null :recycle_location_changes, :longitude, true
    change_column_null :recycle_location_changes, :opening_hours, true
  end
end
