require_relative '../computing_statistics'

RSpec.describe DataSet do
  describe '#record' do
    it 'records a single ms value to the dataset' do
      set = DataSet.new

      set.record(100)

      expect(set.data).to eq([100])
    end

    it 'record multiple entries to the dataset in seperate calls' do
      set = DataSet.new

      set.record(100)
      set.record(200)
      set.record(300)

      expect(set.data).to eq([100, 200, 300])
    end

    it 'records multiple entries with unlimited arguments' do
      set = DataSet.new

      set.record(100, 200, 300)

      expect(set.data).to eq([100, 200, 300])
    end

    it 'raises a TypeError if any input us non numeric' do
      set = DataSet.new

      expect { set.record(100, 'a', 300) }.to raise_error(TypeError)
    end
  end

  describe '#get_user_input' do
    it 'returns the integer a user enters' do
      allow_any_instance_of(Object).to receive(:gets).and_return('121')
      set = DataSet.new

      expect(set.get_user_input).to eq(121)
    end

    it 'prompts the user for the number' do
      allow_any_instance_of(Object).to receive(:gets).and_return('121', '434', '888')
      set = DataSet.new

      expect { set.get_user_input }.to output('Enter a number: ').to_stdout
    end
  end

  describe '#get_dataset' do
    it 'adds numbers until it receives done' do
      allow_any_instance_of(Object).to receive(:gets).and_return('121', '434', '888', 'done')
      set = DataSet.new

      set.get_dataset

      expect(set.data).to eq([121, 434, 888])
    end
  end

  describe '#mean' do
    it 'calculates the mean for a dataset' do
      set = DataSet.new
      set.record(100, 200, 350)

      expect(set.mean).to eq(216.67)
    end
  end

  describe '#max' do
    it 'returns the maximum value of a dataset' do
      set = DataSet.new
      set.record(100, 200, 350)

      expect(set.max).to eq(350)
    end
  end
  
  describe '#min' do
    it 'returns the maximum value of a dataset' do
      set = DataSet.new
      set.record(100, 200, 350)

      expect(set.min).to eq(100)
    end
  end

  describe '#standard_deviation' do
    it 'calculates the standard deviation of a dataset' do
      set = DataSet.new
      set.record(100, 200, 1000, 300)

      expect(set.standard_deviation).to eq(408.25)
    end
  end
end
