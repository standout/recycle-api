class RecycleLocation < ApplicationRecord
  KINDS = %i(recycle_center recycle_station)
  MATERIALS = %w(glass cardboard plastic magazines metal)

  enum kind: KINDS

  reverse_geocoded_by :latitude, :longitude
end
