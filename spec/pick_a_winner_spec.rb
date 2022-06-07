require_relative '../pick_a_winner'

RSpec.describe Lottery do
  describe '#add_name' do
    it 'adds a name to the array of names' do
      lottery = Lottery.new

      lottery.add_name('Harry')

      expect(lottery.names).to eq(['Harry'])
    end

    it 'adds multiple names in the order they arrive' do
      lottery = Lottery.new

      lottery.add_name('Harry')
      lottery.add_name('Jake')

      expect(lottery.names).to eq(['Harry', 'Jake'])
    end
  end

  describe '#get_name_from_user' do
    it 'returns the user input' do
      allow_any_instance_of(Object).to receive(:gets).and_return('Harry')
      lottery = Lottery.new

      expect(lottery.get_name_from_user).to eq('Harry')
    end

    it 'returns a stripped string from the user' do
      allow_any_instance_of(Object).to receive(:gets).and_return("   harry    \n")
      lottery = Lottery.new

      expect(lottery.get_name_from_user).to eq('harry')
    end

    it 'outputs a prompt to the user' do
      allow_any_instance_of(Object).to receive(:gets).and_return('Harry')
      lottery = Lottery.new
      expect { lottery.get_name_from_user }.to output('Enter a name: ').to_stdout
    end
  end

  describe '#add_name_from_user' do
    it 'adds a name from the user to the list of names' do
      allow_any_instance_of(Object).to receive(:gets).and_return('Harry')
      lottery = Lottery.new

      lottery.add_name('Jake')
      lottery.add_name('Oisin')
      lottery.add_name_from_user

      expect(lottery.names).to eq(['Jake', 'Oisin', 'Harry'])
    end
  end

  describe '#populate_names_with_user_input' do
    it 'adds names until the user provides a blank input' do
      allow_any_instance_of(Object).to receive(:gets).and_return('Harry', 'Jake', 'Oisin', '')
      lottery = Lottery.new

      lottery.populate_names_with_user_input

      expect(lottery.names).to eq(['Harry', 'Jake', 'Oisin'])
    end
  end

  describe '#select_winner' do
    it 'selects a random winner' do
      allow_any_instance_of(Object).to receive(:rand).and_return(1)
      lottery = Lottery.new

      lottery.add_name('Harry')
      lottery.add_name('Jake')
      lottery.add_name('Oisin')

      expect(lottery.select_winner).to eq('Jake')
    end

    it 'removes the winner from the array' do
      allow_any_instance_of(Object).to receive(:rand).and_return(1)
      lottery = Lottery.new

      lottery.add_name('Harry')
      lottery.add_name('Jake')
      lottery.add_name('Oisin')
      lottery.select_winner

      expect(lottery.names).to eq(['Harry', 'Oisin'])
    end

    it 'returns nil if the names array is empty' do
      lottery = Lottery.new

      expect(lottery.select_winner).to be nil
    end
  end

  describe '#present_all_winners' do
    before do
      @lottery = Lottery.new

      @lottery.add_name('Harry')
      @lottery.add_name('Jake')
      @lottery.add_name('Oisin')
    end

    it 'selects winners until the list is empty' do
      @lottery.present_all_winners

      expect(@lottery.names).to eq([])
    end

    it 'outputs the winners to the user' do
      allow_any_instance_of(Object).to receive(:rand).and_return(0)
      expected = <<~OUTPUT
Winner 1 is... Harry!
Winner 2 is... Jake!
Winner 3 is... Oisin!
OUTPUT

      expect { @lottery.present_all_winners }.to output(expected).to_stdout
    end
  end
end
