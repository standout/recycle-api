class RecycleLocationsController < ApplicationController
  def index
    @recycle_locations = RecycleLocation.all
  end
end
