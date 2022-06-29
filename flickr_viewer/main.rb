require 'sinatra'
require_relative '../flickr_api'

get '/' do
  @photos = FlickrApi.fetch_photos
  erb :index
end

get '/:tag' do
  @photos = FlickrApi.fetch_photos(params[:tag].split(','))
  erb :tag
end
