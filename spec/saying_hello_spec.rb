require_relative '../saying_hello'

RSpec.describe SayingHello, '#greet' do
  it 'takes input from a user and greets them' do
    allow_any_instance_of(Object).to receive(:gets).and_return('John')

    expect { SayingHello.greet }.to output("What is your name? \nHello, John, nice to meet you!\n").to_stdout
  end

  it 'has a custom greeting for the name katie' do

    allow_any_instance_of(Object).to receive(:gets).and_return('Katie')

    expect { SayingHello.greet }.to output("What is your name? \nKatie! Nice to meet you!\n").to_stdout
  end
end
