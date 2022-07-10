require 'json'
require 'net/http'
require_relative '../time_service'

RSpec.describe TimeService do
  def app
    TimeService.new
  end

  it 'returns the current time as a json string' do
    time = Time.now
    allow(Time).to receive(:now).and_return(time)

    get '/'

    json = JSON.parse(last_response.body)

    expect(json['now']).to eq(time.to_s)
  end
end
