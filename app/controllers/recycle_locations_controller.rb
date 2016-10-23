class RecycleLocationsController < ApplicationController
  def index
    if params[:latitude].present? && params[:longitude].present?
      @recycle_locations =
        RecycleLocation.near([latitude, longitude], 40, units: :km).limit(75)
    else
      head :bad_request
    end
  end

  def update
    # Get relevant attributes from parameters
    change_params = params.except(:controller, :action, :id, :recycle_location)

    # Make change variable that holds new data
    change = RecycleLocationChange.new
    change.reference_id = params[:id]
    
    # For each patched parameter add to change entry
    change_params.each do |k, v|
      # If is single value replace key
      if !v.is_a? (Array)
        change[k] = v
      # If is array replace respective value
      elsif v.is_a? (Array)
        v.each_with_index do |v, i|
          change[k][i] = v
        end
      end
    end

    # Save change to database
    change.save

    head :ok
  end

  private

  def latitude
    params[:latitude].to_f
  end

  def longitude
    params[:longitude].to_f
  end
end
