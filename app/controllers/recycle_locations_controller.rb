class RecycleLocationsController < ApplicationController
  def index
    if params[:latitude].present? && params[:longitude].present?
      @recycle_locations =
        RecycleLocation.near([latitude, longitude], 40, units: :km).limit(75)
    else
      head :bad_request
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
