require 'sinatra'
require_relative 'text'

DB = TextDatabase.new('text.db')

get '/' do
  @recent = DB.recent()

  erb :index
end

post '/new' do
  post = DB.add(params[:text])

  redirect post.show_url, 302
end

post '/update' do
  post = DB.update(params[:slug], params[:text])

  redirect post.show_url, 302
end

get '/:slug/v/:version' do
  @post = DB.get_by_version(params[:slug], params[:version])

  erb :show
end

get '/:slug/all' do
  @slug = params[:slug]
  @posts = DB.get_all(params[:slug])

  erb :show_all
end

get '/:slug/edit' do
  @post = DB.get_most_recent_by_slug(params[:slug])

  erb :edit
end

get '/:slug' do
  @post = DB.get_most_recent_by_slug(params[:slug])

  erb :show
end
