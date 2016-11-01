class ChangeLocationIdNameOnChangesModel < ActiveRecord::Migration[5.0]
  def change
    rename_column :recycle_location_changes, :reference_id, :location_id
  end
end
