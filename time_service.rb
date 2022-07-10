require 'sinatra'
require 'json'

QUOTES = [
  'patience is a virtue',
  'no meek men do great deeds',
  'we will fight them on the beaches',
  'one small step for man, a giant leap for man kind'
]

get '/time' do
  content_type :json
  { now: Time.now }.to_json
end

get '/quote' do
  content_type :json
  { quote: QUOTES.sample }.to_json
end
