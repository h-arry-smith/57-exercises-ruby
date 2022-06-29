# https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid={API key} 

class OpenWeatherMapApi
  attr_reader :api_key, :current_data

  DIRECTIONS = {
    'N' => 0,
    'NNE' => 22.5,
    'NE' => 45,
    'ENE' => 67.5,
    'E' => 90,
    'ESE' => 112.5,
    'SE' => 135,
    'SSE' => 157.5,
    'S' => 180,
    'SSW' => 202.5,
    'SW' => 225,
    'WSW' => 247.5,
    'W' => 270,
    'WNW' => 292.5,
    'NW' => 315,
    'NNW' => 337.5,
  }

  def initialize(api_key)
    @api_key = api_key
  end

  def lat_lon_url(lat, lon)
    "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@api_key}"
  end

  def fetch_lat_lon(lat, lon)
    @current_data = JSON.parse(Net::HTTP.get(URI(lat_lon_url(lat, lon))), symbolize_names: true)
  end

  def city_url(city)
    "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{@api_key}"
  end

  def fetch_city(city)
    @current_data = JSON.parse(Net::HTTP.get(URI(city_url(city))), symbolize_names: true)
  end

  def k_to_pretty_c(kelvin)
    "#{(kelvin - 273.15).round(2)}C"
  end

  def wind_speed_pretty(wind_speed)
    "#{wind_speed} m/s"
  end

  def wind_direction(deg)
    dir = 'N'

    DIRECTIONS.each_pair { |direction, nominal| dir = direction if wind_range(nominal).include? deg }

    dir
  end

  def pretty_print
    output = <<~OUTPUT
Weather Report for #{@current_data[:name]}
It is a #{@current_data[:weather][:main]} day
TEMP: #{k_to_pretty_c(@current_data[:main][:temp])}    HUMIDITY: #{@current_data[:main][:humidity]}%
WIND SPEED: #{wind_speed_pretty(@current_data[:wind][:speed])} #{wind_direction(@current_data[:wind][:deg])}
end
OUTPUT

    puts output
  end
  
  private

  def wind_range(nominal)
    min = nominal - 11.25
    max = nominal + 11.25

    min = 0 if min < 0

    (min..max)
  end
end
