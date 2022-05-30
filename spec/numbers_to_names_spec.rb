require_relative '../numbers_to_names'

GB_MONTHS = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
]

SPANISH_MONTHS = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
]

RSpec.describe MonthMap do
  describe 'adding a translation' do
    it 'supports adding a month mapping' do
      months = MonthMap.new
      months.add(:gb, GB_MONTHS)

      expect(months.gb[1]).to eq('January')
      expect(months.gb[4]).to eq('April')
    end

    it 'supports having multiple translations' do
      months = MonthMap.new
      months.add(:gb, GB_MONTHS)
      months.add(:es, SPANISH_MONTHS)

      expect(months.gb[12]).to eq('December')
      expect(months.es[12]).to eq('Diciembre')
    end

    it 'returns nil for entries that are out of range' do
      months = MonthMap.new
      months.add(:gb, GB_MONTHS)

      expect(months.gb[0]).to be nil
      expect(months.gb[13]).to be nil
    end
  end

  describe 'default mapping' do
    it 'you can set a default and access directly' do
      months = MonthMap.new
      months.add(:gb, GB_MONTHS)
      months.default = :gb

      expect(months[5]).to eq('May')
    end

    it 'raises an error with no default' do
      months = MonthMap.new
      months.add(:gb, GB_MONTHS)

      expect { months[5] }.to raise_exception(NoDefaultSetError)
    end
  end
end
