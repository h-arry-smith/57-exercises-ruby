require_relative '../magic_eight_ball'

RESPONSES = ['Yes', 'No', 'Maybe', 'Try again later']

RSpec.describe EightBall.new do
  it { is_expected.to have_attributes(
    responses: RESPONSES
  )}
end

RSpec.describe EightBall do
  it 'returns a random response for a question' do
    ball = EightBall.new

    expect(ball.ask?('a test')).to(satisfy { |result| RESPONSES.include? result })
  end
end
