module Exceptions
  class ValidationError < StandardError; end

  # Coordinates errors
  class CoordinatesNotPresent < ValidationError; end
  class CoordinatesNotNumerical < ValidationError; end
end
