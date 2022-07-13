require 'sinatra'

require_relative 'urls'

DB = UrlDatabase.new('urls.db')

get '/' do
  @recent = DB.last_ten

  erb :index
end

get '/s/:slug' do
  @url = DB.get(params['slug'])

  DB.visit(params['slug'])

  redirect @url.first[:long_url], 302
end

get '/s/:slug/stats' do
  @url = DB.get(params['slug']).first

  erb :stats
end

post '/new' do
  @long_url = params['long_url']
  @new = DB.add(@long_url)

  erb :new
end

# http://localhost:4567/s/51fc4421
