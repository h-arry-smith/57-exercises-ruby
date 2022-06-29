require 'net/http'
require 'json'

class FlickrApi
  BASE_URL = 'https://www.flickr.com/services/feeds/photos_public.gne?format=json'

  def self.request_url(tags)
    if tags.empty?
      BASE_URL
    else
      "#{BASE_URL}&tags=#{tags.join(',')}"
    end
  end

  def self.fetch_data(tags)
    data = Net::HTTP.get(URI(request_url(tags)))

    data.delete_prefix!('jsonFlickrFeed(')
    data.delete_suffix!(')')

    JSON.parse(data, symbolize_names: true)
  end

  def self.fetch_photos(tags = [], n = 3)
    data = fetch_data(tags)

    data[:items].take(n)
  end
end
