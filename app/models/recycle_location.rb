class RecycleLocation < ApplicationRecord
  KINDS = %i(recycle_center recycle_station).freeze
  MATERIALS = %w(glass cardboard plastic magazines metal).freeze

  enum kind: KINDS

  reverse_geocoded_by :latitude, :longitude
end
