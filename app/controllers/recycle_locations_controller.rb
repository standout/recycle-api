class RecycleLocationsController < ApplicationController
  def index
    @recycle_locations = RecycleLocation.limit(100)
  end
end
