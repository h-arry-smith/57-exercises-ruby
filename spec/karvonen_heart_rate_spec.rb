require_relative '../karvonen_heart_rate'

RSpec.describe HeartRateTable do
  before do
    @hrt = HeartRateTable.new(22, 65)
  end

  it 'has a resting heart rate and an age' do
    expect(@hrt.age).to be(22)
    expect(@hrt.resting_rate).to be(65)
  end

  it 'rejects non-numeric values for initialisation' do
    expect { HeartRateTable.new('test', 65) }.to raise_exception(TypeError)
    expect { HeartRateTable.new(22, 'test') }.to raise_exception(TypeError)
  end

  describe '#rate_at_intensity' do
    it 'calculates the correct rate to a whole number for a given intensity' do
      expect(@hrt.rate_at_intensity(0.55)).to eq(138)
      expect(@hrt.rate_at_intensity(0.60)).to eq(145)
    end
  end

  describe '#table' do
    it 'calculates a table of intensities given a range' do
      expected = [
        HRTTableRow.new(55, 138),
        HRTTableRow.new(60, 145),
        HRTTableRow.new(65, 151)
      ]

      expect(@hrt.table(55, 65)[0].intensity).to eq(expected[0].intensity)
      expect(@hrt.table(55, 65)[1].intensity).to eq(expected[1].intensity)
      expect(@hrt.table(55, 65)[2].intensity).to eq(expected[2].intensity)
    end
  end
end

ExampleData = Struct.new(:longer, :two, :three) do
end

RSpec.describe TablePrinter do
  SYMBOLS = [:longer, :two, :three]
  DATA = [ExampleData.new(1, 2, 3), ExampleData.new(4, 5, 6)]

  it 'takes a list of symbols, and a list of data' do
    printer = TablePrinter.new(SYMBOLS, DATA)

    expect(printer.symbols).to eq(SYMBOLS)
    expect(printer.data).to eq(DATA)
  end

  describe 'output functions' do
    it 'prints a correctly formatted header line with three headers' do
      printer = TablePrinter.new(SYMBOLS, DATA)

      expected = " Longer   | Two   | Three   \n"
      expect { printer.put_header }.to output(expected).to_stdout
    end

    it 'prints the diving line of the right length' do
      printer = TablePrinter.new(SYMBOLS, DATA)
      expected = "----------------------------\n"

      expect { printer.put_divider }.to output(expected).to_stdout
    end

    it 'prints a column of data with the correct padding' do
      printer = TablePrinter.new(SYMBOLS, DATA)
      expected = " 1        | 2     | 3       \n"

      expect { printer.put_data(DATA[0]) }.to output(expected).to_stdout
    end

    it 'prints a table with all the correct output' do
      printer = TablePrinter.new(SYMBOLS, DATA)
      expected = <<OUTPUT
 Longer   | Two   | Three   
----------------------------
 1        | 2     | 3       
 4        | 5     | 6       
OUTPUT

      expect { printer.put_table }.to output(expected).to_stdout
    end
  end
end

RSpec.describe "Integration Test" do
  it "prints the correct table for a small range of heart rates" do
    hrt = HeartRateTable.new(22, 65)
    printer = TablePrinter.new(
      [:intensity, :target_rate],
      hrt.table(55, 65)
    )
    expected = <<OUTPUT
 Intensity   | Target Rate   
-----------------------------
 55%         | 138bpm        
 60%         | 145bpm        
 65%         | 151bpm        
OUTPUT

    expect { printer.put_table }.to output(expected).to_stdout
  end
end
