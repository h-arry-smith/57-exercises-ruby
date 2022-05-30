class TaxCalculator
  TAX = {
    wisconsin: {
      default: 0.05,
      eau_claire: 0.005,
      dunn: 0.004
    },
    illinois: {
      default: 0.08
    },
    default: {
      default: 0
    }
  }

  # For brevity only one example is given, but logic would work for all states
  STATE_ABBREVIATIONS = {
    wi: :wisconsin
  }

  def self.tax_for(amount_in_cents, state = nil, county = nil)
    tax = tax_for_state_county(
      normalise_name(state),
      normalise_name(county)
    )

    SalesReceipt.new(amount_in_cents, amount_in_cents * tax)
  end

  def self.tax_for_state_county(state = nil, county = nil)
    state = get_state(state)
    state_tax = state[:default]
    county_tax = get_county(state, county)

    state_tax + county_tax
  end

  def self.get_state(state)
    return TAX[:default] unless TAX.key? state

    TAX[state]
  end

  def self.get_county(state, county)
    return 0 unless state.key? county

    state[county]
  end

  def self.normalise_name(name)
    normalised_symbol = name.to_s.downcase.gsub(' ', '_').to_sym

    return STATE_ABBREVIATIONS[normalised_symbol] if STATE_ABBREVIATIONS.key? normalised_symbol

    normalised_symbol
  end
end

SalesReceipt = Struct.new(:amount, :tax) do
end
