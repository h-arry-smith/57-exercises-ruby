require_relative '../bmi'

RSpec.describe Height do
  describe '#new' do
    it 'has a value in cm' do
      height = Height.new(173)

      expect(height.value).to eq(173)
    end
  end

  describe 'conversion' do
    it 'can create a height in cm' do
      height = Height.cm(173)

      expect(height.value).to eq(173)
    end

    it 'can create a height in inches' do
      height = Height.inches(89)

      expect(height.value).to eq(226.06)
    end
  end

  it 'can be compared directly' do
    height = Height.cm(190)

    expect(height == 190).to be true
  end

  it 'can be divided' do
    height = Height.cm(190)

    expect(height / 10.0).to eq(19.0)
  end
end

RSpec.describe Weight do
  describe '#new' do
    it 'has a value in kgs' do
      weight = Weight.new(90)

      expect(weight.value).to eq(90)
    end
  end

  describe 'conversion' do
    it 'can create a weight in kg' do
      weight = Weight.kg(90)

      expect(weight.value).to eq(90)
    end

    it 'can create a weight in lbs' do
      weight = Weight.lb(200)

      expect(weight.value).to eq(90.72)
    end
  end

  it 'can be compared directly' do
    weight = Weight.kg(90)

    expect(weight == 90).to be true
  end

  it 'can be divided' do
    weight = Weight.kg(90)

    expect(weight / 10.0).to eq(9.0)
  end
end

RSpec.describe Person do
  describe '#new' do
    it 'has a weight and height' do
      person = Person.new(
        Height.cm(190),
        Weight.kg(80)
      )

      expect(person.height == 190).to be true
      expect(person.weight == 80).to be true
    end
  end

  describe '#bmi' do
    it 'returns the correct BMI' do
      person = Person.new(
        Height.cm(190),
        Weight.kg(80)
      )

      expect(person.bmi).to eq(22.16)
    end
  end

  describe '#overweight?' do
    it 'returns true for overweight people' do
      healthy_person = Person.new(
        Height.cm(190),
        Weight.kg(80)
      )
      unhealthy_person = Person.new(
        Height.cm(190),
        Weight.kg(120)
      )

      expect(healthy_person.overweight?).to be false
      expect(unhealthy_person.overweight?).to be true
    end
  end
end
