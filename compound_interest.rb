class InterestCalculator
  def self.compound(principal, rate, number_of_years, compounds_per_year)
    raise ArgumentError unless all_numeric?(principal, rate, number_of_years, compounds_per_year)

    (
      principal *
        (1 + (rate / 100.0) / compounds_per_year)**
          (compounds_per_year * number_of_years)
    ).ceil(2)
  end

  def self.how_much?(target, rate, number_of_years, compounds_per_year)
    (
      target /
        (1 + (rate / 100.0) / compounds_per_year)**
          (compounds_per_year * number_of_years)
    ).round(2)
  end

  def self.all_numeric?(*args)
    args.all? { |arg| arg.is_a? Numeric }
  end
end
