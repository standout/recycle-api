class RecycleLocationChangesController < ApplicationController
  def create
    # Make change variable that holds new data
    change = RecycleLocationChange.new
    change.import_from_params(params)

    # Save change to database
    change.save

    head :ok
  end
end
