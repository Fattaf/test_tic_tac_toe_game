require 'thin'
require 'json'
require 'sinatra/base'
require 'sinatra-websocket'
require 'sinatra/assetpack'

Dir['./libs/**/*.rb'].each do |file|
  require file
end

require './app.rb'

Rack::Handler::Thin.run App.new, :Port => 3000
