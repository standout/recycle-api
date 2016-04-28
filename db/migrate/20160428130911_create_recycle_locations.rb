class CreateRecycleLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :recycle_locations do |t|
      t.string  :name,      null: false
      t.integer :kind,      null: false
      t.text    :materials, null: false, array: true, default: []
      t.float   :latitude,  null: false
      t.float   :longitude, null: false
      t.string  :street_name
      t.string  :zip_code
      t.string  :city

      t.timestamps
    end
  end
end
