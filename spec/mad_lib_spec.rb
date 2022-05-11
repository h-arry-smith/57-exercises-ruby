require 'stringio'
require_relative '../mad_lib'

RSpec.describe MadLibGenerator do
  it 'generates a default mad lib structure' do
    generator = MadLibGenerator.new

    expect(generator.noun).to eq('')
    expect(generator.verb).to eq('')
    expect(generator.adjective).to eq('')
    expect(generator.adverb).to eq('')
    expect(generator.format).to eq("Do you %s your %s %s %s? That's hilarious!")
  end

  it 'given a list of values will create a mad lib with those elements' do
    generator = MadLibGenerator.new(%w[one two three], '%s %s %s')

    expect(generator.one).to eq('')
    expect(generator.two).to eq('')
    expect(generator.three).to eq('')
  end

  it 'will raise an error if format string has incorrect number of placeholders' do
    expect { MadLibGenerator.new(%w[one two three], '%s %s') }.to raise_exception(BadFormatString)
  end

  describe '#set_element_to_user_input' do
    it 'outputs the correct user prompt for an element' do
      generator = MadLibGenerator.new
      allow_any_instance_of(Object).to receive(:gets).and_return('')

      expect { generator.set_element_to_user_input(:noun) }.to output("Enter a noun: \n").to_stdout
    end

    it 'given a user input sets it an element to a clean version' do
      allow_any_instance_of(Object).to receive(:gets).and_return('test       ')
      generator = MadLibGenerator.new

      generator.set_element_to_user_input(:noun)

      expect(generator.noun).to eq('test')
    end

    it 'raises an error if the element does not exist' do
      allow_any_instance_of(Object).to receive(:gets).and_return('test       ')
      generator = MadLibGenerator.new

      expect { generator.set_element_to_user_input(:not_present_ever) }.to raise_exception(NoElementError)
    end
  end

  describe '#get_mad_lib_from_user' do
    it 'sets all the mad lib values from user input' do
      allow_any_instance_of(Object).to receive(:gets).and_return('something')
      expected_output = <<~EXPECTED
Enter a verb: 
Enter a adjective: 
Enter a noun: 
Enter a adverb: 
EXPECTED

      generator = MadLibGenerator.new

      expect { generator.get_mad_lib_from_user }.to output(expected_output).to_stdout

      expect(generator.noun).to eq('something')
      expect(generator.verb).to eq('something')
      expect(generator.adjective).to eq('something')
      expect(generator.adverb).to eq('something')
    end
  end

  describe '#print_mad_lib' do
    it 'prints the mad lib to the screen' do
      expected = "Do you walk your blue dog quickly? That's hilarious!\n"
      generator = MadLibGenerator.new

      generator.noun = 'dog'
      generator.verb = 'walk'
      generator.adjective = 'blue'
      generator.adverb = 'quickly'

      expect { generator.print_mad_lib }.to output(expected).to_stdout
    end

    it 'prints correctly for a custom formatted mad lib' do
      expected = "Woah! he said timidly as he jumped into his convertible clown car and drove off with his ugly wife.\n"
      generator = MadLibGenerator.new(
        %w[exclamation adverb noun adjective],
        '%s! he said %s as he jumped into his convertible %s and drove off with his %s wife.'
      )

      generator.exclamation = 'Woah'
      generator.adverb = 'timidly'
      generator.noun = 'clown car'
      generator.adjective = 'ugly'

      expect { generator.print_mad_lib }.to output(expected).to_stdout
    end
  end
end
