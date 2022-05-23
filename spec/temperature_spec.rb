require_relative '../temperature'

RSpec.describe Temperature do
  describe 'creating temperatures' do
    it 'can create celsius temperatures' do
      temp = Temperature.celsius(50)

      expect(temp.celsius).to eq(50)
      expect(temp.unit).to eq(:c)
    end

    it 'can create farenheit temperatures' do
      temp = Temperature.farenheit(50)

      expect(temp.farenheit).to eq(50)
      expect(temp.unit).to eq(:f)
    end

    it 'can create kelvin temperatures' do
      temp = Temperature.kelvin(50)

      expect(temp.kelvin).to eq(50)
      expect(temp.unit).to eq(:k)
    end

    it 'rejects non numeric values' do
      expect { Temperature.celsius('hello') }.to raise_exception(TypeError)
    end
  end

  describe '#convert' do
    it 'converts from celsius to farenheit' do
      temp = Temperature.celsius(50)

      expect(temp.convert(:f)).to eq(122)
    end

    it 'converts from celsius to kelvin' do
      temp = Temperature.celsius(50)

      expect(temp.convert(:k)).to eq(323.15)
    end

    it 'converts from farenheit to celsius' do
      temp = Temperature.farenheit(122)

      expect(temp.convert(:c)).to eq(50)
    end

    it 'converts from farenheit to kelvin' do
      temp = Temperature.farenheit(122)

      expect(temp.convert(:k)).to eq(323.15)
    end

    it 'converts from kelvin to celsius' do
      temp = Temperature.kelvin(323.15)

      expect(temp.convert(:c)).to eq(50)
    end

    it 'converts from kelvin to farenheit' do
      temp = Temperature.kelvin(323.15)

      expect(temp.convert(:f)).to eq(122)
    end

    it 'returns the same for same unit' do
      c = Temperature.celsius(50)
      f = Temperature.farenheit(50)
      k = Temperature.kelvin(50)

      expect(c.convert(:c)).to eq(50)
      expect(f.convert(:f)).to eq(50)
      expect(k.convert(:k)).to eq(50)
    end
  end

  describe 'implicit conversion' do
    it 'handles celsius implicit conversions' do
      temp = Temperature.celsius(50)

      expect(temp.farenheit).to eq(122)
      expect(temp.kelvin).to eq(323.15)
    end

    it 'handles farenheit implicit conversions' do
      temp = Temperature.farenheit(122)

      expect(temp.celsius).to eq(50)
      expect(temp.kelvin).to eq(323.15)
    end

    it 'handles kelvin implicit conversions' do
      temp = Temperature.kelvin(323.15)

      expect(temp.celsius).to eq(50)
      expect(temp.farenheit).to eq(122)
    end
  end
end
