require_relative '../blood_alcohol'

RSpec.describe BloodAlcoholCalculator do
  describe '#new' do
    it 'has the correct ratio for men' do
      expect(BloodAlcoholCalculator.new(:male).ratio).to eq(0.73)
    end

    it 'has the correct ratio for women' do
      expect(BloodAlcoholCalculator.new(:female).ratio).to eq(0.66)
    end

    it 'has a default body weight for men' do
      expect(BloodAlcoholCalculator.new(:male).weight).to eq(197.9)
    end
    
    it 'has a default body weight for women' do
      expect(BloodAlcoholCalculator.new(:female).weight).to eq(167.6)
    end
  end

  describe '#add_drink' do
    before do
      @calc = BloodAlcoholCalculator.new(:male)
    end

    it 'adds a drink to the list' do
      time = Time.now

      @calc.add_drink(10, time)

      expect(@calc.drinks).to eq([{oz: 10, time: time}])
    end

    it 'does not accept non positive drink amounts' do
      expect { @calc.add_drink(-10, Time.now) }.to raise_exception(ArgumentError)
    end

    it 'will default the time to current time when not provided' do
      @calc.add_drink(10)
    end
  end

  describe '#hours_since_last_drink' do
    before do
      @calc = BloodAlcoholCalculator.new(:male)
    end

    it 'returns 0 when there are no drinks' do
      expect(@calc.hours_since_last_drink).to eq(0)
    end

    it 'returns 0 when the drink was recent' do
      @calc.add_drink(10)
      expect(@calc.hours_since_last_drink).to eq(0)
    end

    it 'returns the hours since the the last drink' do
      @calc.add_drink(10, Time.now - 2 * 60 * 60)
      @calc.add_drink(10, Time.now - 1 * 60 * 60)

      expect(@calc.hours_since_last_drink).to eq(1)
    end
  end

  describe '#total_alcohol' do
    it 'returns the total alcohol consumed' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(1)
      calc.add_drink(2)
      calc.add_drink(3)

      expect(calc.total_alcohol).to eq(6)
    end
  end

  describe '#bac' do
    it 'calculates the correct BAC for one drink recently' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(10)

      expect(calc.bac).to eq(0.19)
    end

    it 'caculates the correct BAC for one drink an hour ago' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(10, Time.now - 1 * 60 * 60)

      expect(calc.bac).to eq(0.175)
    end

    it 'calculates the correct BAC for multiple drinks' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(1, Time.now - 2 * 60 * 60)
      calc.add_drink(4, Time.now - 2 * 60 * 60)
      calc.add_drink(5, Time.now - 1 * 60 * 60)

      expect(calc.bac).to eq(0.175)
    end
  end

  describe '#drive?' do
    it 'returns true if the BAC is in legal range' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(10, Time.now - 8 * 60 * 60)

      expect(calc.drive?).to be true
    end

    it 'returns false if the BAC is outside legal range' do
      calc = BloodAlcoholCalculator.new(:male)
      calc.add_drink(10, Time.now - 2 * 60 * 60)

      expect(calc.drive?).to be false
    end
  end
end
