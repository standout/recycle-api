class CoordinateValidation < Validation
  class << self
    def validate(params)
      if !(params[:latitude].present? && params[:longitude].present?)
        raise Exceptions::CoordinatesNotPresent
      elsif !(is_numerical?(params[:longitude]) && is_numerical?(params[:latitude]))
        raise Exceptions::CoordinatesNotNumerical
      end
    end
  end
end
