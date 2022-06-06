class EightBall
  attr_reader :responses

  def initialize
    @responses = ['Yes', 'No', 'Maybe', 'Try again later']
  end

  def ask?(_question)
    @responses[rand(0..@responses.length - 1)]
  end
end
