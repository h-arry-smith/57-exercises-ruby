require 'net/http'
require 'json'
require_relative '../grabbing_the_weather'

TEST_DATA = {
  weather: {
    main: 'Clear',
    description: 'clear sky'
  },
  main: {
    temp: 282.55,
    feels_like: 281.86,
    humidity: 100
  },
  wind: {
    speed: 1.5,
    deg: 350
  },
  name: 'Mountain View'
}

RSpec.describe OpenWeatherMapApi do
  it 'create an instance with an api key' do
    api = OpenWeatherMapApi.new('test-key')

    expect(api.api_key).to eq('test-key')
  end

  it 'returns a url string for a request for a given latitude and longtitude' do
    api = OpenWeatherMapApi.new('test-key')

    expect(api.lat_lon_url(35, 139)).to eq('https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=test-key')
  end

  it 'fetches data for a lat lon and stores it in the current data attribute' do
    api = OpenWeatherMapApi.new('test-key')

    allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

    api.fetch_lat_lon(35, 139)

    expect(api.current_data).to be_a_kind_of(Hash)
    expect(api.current_data[:name]).to eq('Mountain View')
  end
  
  it 'returns a url string for a request for a given city' do
    api = OpenWeatherMapApi.new('test-key')

    expect(api.city_url('test')).to eq('https://api.openweathermap.org/data/2.5/weather?q=test&appid=test-key')
  end

  it 'fetches data for a lat lon and stores it in the current data attribute' do
    api = OpenWeatherMapApi.new('test-key')

    allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

    api.fetch_city('Mountain View')

    expect(api.current_data).to be_a_kind_of(Hash)
    expect(api.current_data[:name]).to eq('Mountain View')
  end

  describe 'pretty print' do
    it '#k_to_pretty_c' do
      api = OpenWeatherMapApi.new('test-key')

      expect(api.k_to_pretty_c(200)).to eq('-73.15C')
      expect(api.k_to_pretty_c(201)).to eq('-72.15C')
    end

    it '#wind_speed_pretty' do
      api = OpenWeatherMapApi.new('test-key')

      expect(api.wind_speed_pretty(1.5)).to eq('1.5 m/s')
      expect(api.wind_speed_pretty(2.5)).to eq('2.5 m/s')
    end

    it '#wind_direction' do
      api = OpenWeatherMapApi.new('test-key')

      expect(api.wind_direction(0)).to eq('N')
      expect(api.wind_direction(22.5)).to eq('NNE')
      expect(api.wind_direction(45)).to eq('NE')
      expect(api.wind_direction(67.5)).to eq('ENE')
      expect(api.wind_direction(90)).to eq('E')
      expect(api.wind_direction(112.5)).to eq('ESE')
      expect(api.wind_direction(135)).to eq('SE')
      expect(api.wind_direction(157.5)).to eq('SSE')
      expect(api.wind_direction(180)).to eq('S')
      expect(api.wind_direction(202.5)).to eq('SSW')
      expect(api.wind_direction(225)).to eq('SW')
      expect(api.wind_direction(247.5)).to eq('WSW')
      expect(api.wind_direction(270)).to eq('W')
      expect(api.wind_direction(292.5)).to eq('WNW')
      expect(api.wind_direction(315)).to eq('NW')
      expect(api.wind_direction(337.5)).to eq('NNW')
    end

    it '#handles north where nominal range loops past 360' do
      api = OpenWeatherMapApi.new('test-key')

      expect(api.wind_direction(355)).to eq('N')
    end

    it 'displays to the user a nicely formatted weather report' do
      api = OpenWeatherMapApi.new('test-key')
      expected = <<~OUTPUT
Weather Report for Mountain View
It is a Clear day
TEMP: 9.4C    HUMIDITY: 100%
WIND SPEED: 1.5 m/s N
end
OUTPUT

      allow(Net::HTTP).to receive(:get).and_return(TEST_DATA.to_json)

      api.fetch_city('test')

      expect { api.pretty_print }.to output(expected).to_stdout
    end
  end
end
