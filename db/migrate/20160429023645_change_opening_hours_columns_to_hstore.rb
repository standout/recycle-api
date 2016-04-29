class ChangeOpeningHoursColumnsToHstore < ActiveRecord::Migration[5.0]
  def change
    remove_column :recycle_locations, :opening_hours
    add_column :recycle_locations, :opening_hours, :json, null: false, default: Array.new(7)
  end
end
