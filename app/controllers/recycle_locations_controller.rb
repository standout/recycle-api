class RecycleLocationsController < ApplicationController
  before_action :authenticate_with_token, only: [:update]

  def index
    if params[:latitude].present? && params[:longitude].present?
      @recycle_locations =
        RecycleLocation.near([latitude, longitude], 40, units: :km).limit(75)
    else
      head :bad_request
    end
  end

  def update
    hash = params.permit!.to_h

    # Merge change with recycle location
    RecycleLocationChange.find(hash['change_id']).apply(hash)
    head :ok
  end

  def get_pending_changes
    all_changes = RecycleLocationChange.all
    @differences = []

    # Return all differences from pending changes
    all_changes.each do |change|
      @differences << change.compare
    end
  end

  private

  def latitude
    params[:latitude].to_f
  end

  def longitude
    params[:longitude].to_f
  end
end
