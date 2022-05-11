require_relative '../counting_characters'

RSpec.describe CountingCharacters, '#count_chars' do
  it 'counts the number of characters in the supplied string' do
    allow_any_instance_of(Object).to receive(:gets).and_return('Homer')

    expect { CountingCharacters.count_chars }.to output("What is the input string? \nHomer has 5 characters.\n").to_stdout
  end

  it 'shows the user an error if an empty string is provided' do
    allow_any_instance_of(Object).to receive(:gets).and_return('')

    expect { CountingCharacters.count_chars }.to output("What is the input string? \nYou must enter a non empty string.\n").to_stdout
  end
end
