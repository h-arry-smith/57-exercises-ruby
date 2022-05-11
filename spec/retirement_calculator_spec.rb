require_relative '../retirement_calculator'

RSpec.describe RetirementCalculator do
  it 'has an age and a target retirement age' do
    calc = RetirementCalculator.new

    expect(calc.age).to eq(0)
    expect(calc.retirement_age).to eq(0)
  end

  it 'can initialise with values' do
    calc = RetirementCalculator.new(20, 65)

    expect(calc.age).to eq(20)
    expect(calc.retirement_age).to eq(65)
  end

  it 'calculates years until retirement' do
    calc = RetirementCalculator.new(20, 65)

    expect(calc.years_until_retirement).to eq(45)
  end

  it 'tells you if you can retire yet' do
    can_retire = RetirementCalculator.new(70, 65)
    cant_retire = RetirementCalculator.new(20, 65)

    expect(can_retire.can_retire?).to be true
    expect(cant_retire.can_retire?).to be false
  end

  it 'given the current year can calculate the year you retire' do
    calc = RetirementCalculator.new(20, 65)

    expect(calc.retirement_year(2015)).to eq(2060)
  end

  it 'given no year calculates the year you retire from system time' do
    calc = RetirementCalculator.new(20, 21)
    expected_year = Time.new.year + 1

    expect(calc.retirement_year).to eq(expected_year)
  end

  it 'gets current year from the system' do
    calc = RetirementCalculator.new
    current_year = Time.new.year

    expect(calc.current_year).to eq(current_year)
  end

  it 'displays retirement information when waiting to retire' do
    calc = RetirementCalculator.new(25, 65)
    current_year = Time.new.year

    expected = <<~EXPECTED
Your age is: 25
You want to retire when you are: 65
You have 40 years until you can retire
It is #{current_year}, so you can retire in #{current_year+40}
EXPECTED

    expect { calc.display }.to output(expected).to_stdout
  end
  
  it 'tells the user they can already retire if they are able' do
    calc = RetirementCalculator.new(70, 65)
    current_year = Time.new.year

    expected = <<~EXPECTED
Your age is: 70
You want to retire when you are: 65
You can already retire!
EXPECTED

    expect { calc.display }.to output(expected).to_stdout
  end
end
