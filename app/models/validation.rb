class Validation
  class << self
    # Translated to human language:
    # Match string that looks like <numbers> <dot> <numbers> or <numbers>
    # Also means <dot> <numbers> won't evaluate to true
    def is_numerical?(string)
      /^(\d+[,.]?\d+)$/ === string
    end
  end
end
