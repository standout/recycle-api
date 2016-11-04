class CoordinateValidation < Validation
  class << self
    def validate(params)
      if !(params[:latitude].present? && params[:longitude].present?)
        raise CoordinatesNotPresent, "No coordinates provided in params"
      elsif !(is_numerical?(params[:longitude]) && is_numerical?(params[:latitude]))
        raise CoordinatesNotNumerical, "Coordinates not numerical"
      end
    end
  end
end
