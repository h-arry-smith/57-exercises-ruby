require_relative '../driving_age'

RSpec.describe DrivingAgeCalculator do
  before do
    @calc = DrivingAgeCalculator.new
  end

  describe '#drive?' do
    it 'returns true if they can drive' do
      expect(@calc.drive?(25, 17)).to be true
    end

    it 'returns false if they can not drive yet' do
      expect(@calc.drive?(16, 17)).to be false
    end

    it 'returns true at the boundary condition' do
      expect(@calc.drive?(17, 17)).to be true
    end

    it 'does not allow negative ages' do
      expect { @calc.drive?(-1, 17) }.to raise_exception(ArgumentError)
    end

    it 'does not allow non-numeric ages' do
      expect { @calc.drive?('test', 17) }.to raise_exception(ArgumentError)
      expect { @calc.drive?(1, 'test') }.to raise_exception(ArgumentError)
    end
  end

  describe '#driving_age' do
    it 'returns the driving age given a country symbol' do
      @calc = DrivingAgeCalculator.new({test_country: 20})

      expect(@calc.driving_age(:test_country)).to eq(20) 
    end

    it 'returns nil for a driving age that isnt in the map' do
      @calc = DrivingAgeCalculator.new({test_country: 20})

      expect(@calc.driving_age(:no_country)).to be nil
    end

    it 'returns defaults' do
      expect(@calc.driving_age(:uk)).to eq(17)
    end
  end

  describe '#drive_in?' do
    it 'test to drive in the uk' do
      expect(@calc.drive_in?(17, :uk))
    end

    it 'test to drive in the fra' do
      expect(@calc.drive_in?(18, :fra))
    end

    it 'test to drive in germany' do
      expect(@calc.drive_in?(18, :ger))
    end

    it 'raises an error if the country does not exist' do
      expect { @calc.drive_in?(25, :not_found) }.to raise_exception(CountryNotFoundError)
    end
  end
end
