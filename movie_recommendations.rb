# RottenTomato is no longer available as an easy access API. Using the TMDB Instead for some version
# of this challenge.
require 'json'
require 'net/http'

KEY = JSON.parse(File.read('secrets/movie.json'))['key']

class MovieRecommender
  BASE_URL = 'https://api.themoviedb.org/3/search/movie?api_key='

  def initialize(api_key)
    @key = api_key
  end

  def search_url(term)
    "#{BASE_URL}#{@key}&query=#{term.gsub(' ', '+')}"
  end

  def search(term)
    request = Net::HTTP.get(URI(search_url(term)))
    data = JSON.parse(request)

    {
      metadata: {
        total_results: data['total_results'],
        results: data['results'].length
      },
      results: data['results'].map { |movie_data| Movie.new(movie_data) }
    }
  end
end

class Movie
  attr_reader :id, :title, :description, :release_date, :rating

  def initialize(data)
    @id = data['id']
    @title = data['title']
    @description = data['overview']
    @release_data = data['release_date']
    @rating = data['vote_average']
  end

  def print
    puts <<~OUTPUT
Title: #{@title}
Release Date: #{@release_dae}
Rating: #{@rating} / 10.0
---
#{@description}
---

OUTPUT
  end
end

MR = MovieRecommender.new(KEY)

