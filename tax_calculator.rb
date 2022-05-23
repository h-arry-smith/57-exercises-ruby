class TaxCalculator
  TAX_RATE = 0.055

  def self.tax(amount, state)
    return 0 unless wi? state

    amount * TAX_RATE
  end

  def self.wi?(state)
    %w[wi wisconsin].include? state.downcase
  end
end
