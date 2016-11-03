class RecycleLocationsController < ApplicationController
  before_action :authenticate_with_token, only: [:update]

  def index
    CoordinateValidation.validate(params)

    @recycle_locations =
      RecycleLocation.near([latitude, longitude], 40, units: :km).limit(75)
    respond_with(@recycle_locations)

    rescue Exceptions::CoordinatesNotPresent => e
      respond_with( error_message(e, "No coordinates provided in params") )
    rescue Exceptions::CoordinatesNotNumerical => e
      respond_with( error_message(e, "Coordinates not numerical") )
  end

  def update
    hash = params.permit!.to_h

    # Merge change with recycle location
    RecycleLocationChange.find(hash['change_id']).apply(hash)

    head :ok

    rescue ActiveRecord::RecordNotFound => e
      respond_with( error_message(e, "Specified change not found") )
  end

  def get_pending_changes
    all_changes = RecycleLocationChange.all
    @differences = []

    # Return all differences from pending changes
    all_changes.each do |change|
      @differences << change.compare
    end

    respond_with(@differences)
  end

  private

  def latitude
    params[:latitude].to_f
  end

  def longitude
    params[:longitude].to_f
  end
end
