class RecycleLocation < ApplicationRecord
  KINDS = %i(recycle_center recycle_station)
  MATERIALS = %w(glass cardboard plastic magazines metal)

  enum kind: KINDS
end
