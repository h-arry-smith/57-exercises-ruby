require_relative '../simple_math'

RSpec.describe SimpleMath do
  describe '#gets_number' do
    before do
      allow_any_instance_of(Object).to receive(:gets).and_return('11')
    end

    it 'asks the user for the number when no name is given' do
      expect { SimpleMath.gets_number }.to output("What is the number? \n").to_stdout
    end

    it 'asks the user for the number with a name when given' do

      expect { SimpleMath.gets_number('first') }.to output("What is the first number? \n").to_stdout
    end
    
    it 'gets a user inputted number and returns as an integer' do

      expect(SimpleMath.gets_number).to eq(11)
    end

    it 'does not allow negative numbers' do
      allow_any_instance_of(Object).to receive(:gets).and_return('-11')
      expected = "What is the first number? \nNegative numbers are not allowed.\n"

      expect { SimpleMath.gets_number('first') }.to output(expected).to_stdout
    end
  end

  describe '#display_computation' do
    it 'outputs the computations for two numbers' do
      expected = <<~EXPECTED
10 + 5 = 15
10 - 5 = 5
10 * 5 = 50
10 / 5 = 2
EXPECTED

      expect { SimpleMath.display_computation(10, 5) }.to output(expected).to_stdout
    end
  end

  describe '#compute_two_numbers' do
    it 'asks the user for two numbers and displats the computation' do
      allow_any_instance_of(Object).to receive(:gets).and_return('10')

      expected = <<~EXPECTED
What is the first number? 
What is the second number? 
10 + 10 = 20
10 - 10 = 0
10 * 10 = 100
10 / 10 = 1
EXPECTED

      expect { SimpleMath.compute_two_numbers }.to output(expected).to_stdout
    end
    
    it 'bails if a negative number is given' do
      allow_any_instance_of(Object).to receive(:gets).and_return('-10')

      expected = <<~EXPECTED
What is the first number? 
Negative numbers are not allowed.
EXPECTED

      expect { SimpleMath.compute_two_numbers }.to output(expected).to_stdout
    end
  end

  describe 'computation functions' do
    it '#add' do
      expect(SimpleMath.add(1, 2)).to eq(3)
    end
    it '#sub' do
      expect(SimpleMath.sub(4, 3)).to eq(1)
    end
    it '#div' do
      expect(SimpleMath.div(10, 2)).to eq(5)
    end
    it '#mul' do
      expect(SimpleMath.mul(4, 2)).to eq(8)
    end
  end
end
