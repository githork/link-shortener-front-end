require 'firebase'
require 'sinatra'

set :server, 'webrick'
set :environment, :production
set :port, ENV['PORT'] || 3000

get '/' do
  redirect 'https://github.com/tommyku/link-shortener-front-end'
end

get '/:short_key' do |short_key|
  base_uri = ENV['FIREBASE_BASE_URI']
  secret_key = ENV['FIREBASE_SECRET_KEY']
  firebase = Firebase::Client.new(base_uri, secret_key)
  response = firebase.get("#{short_key}")
  if response.body
    target = response.body.first[1]
    redirect target
  else
    "I've got nothing for you, try maybe another castle"
  end
end
