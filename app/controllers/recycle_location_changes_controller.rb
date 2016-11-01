class RecycleLocationChangesController < ApplicationController
  def create
    # Make change variable that holds new data
    change = RecycleLocationChange.new
    change.import_from_params(params)

    # Save change to database
    if change.save
      head :ok
    else
      head :bad_request
    end
  end
end
