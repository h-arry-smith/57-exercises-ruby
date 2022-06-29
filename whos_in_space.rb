require 'net/http'

class WhosInSpaceApi
  REQUEST_URI = URI('http://api.open-notify.org/astros.json')

  def self.data
    JSON.parse(request, symbolize_names: true)
  end

  def self.number_of_people_in_space
    data[:number]
  end

  def self.people_in_space
    data[:people]
  end

  def self.people_in_space_by_craft
    by_craft = {}

    data[:people].each do |person|
      craft = person[:craft]

      if by_craft[craft]
        by_craft[craft] << person
      else
        by_craft[craft] = [person]
      end
    end

    by_craft
  end

  def self.request
    Net::HTTP.get(REQUEST_URI)
  end
end
