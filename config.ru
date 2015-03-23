require 'thin'
require 'json'
require 'sinatra/base'
require 'sinatra-websocket'
require 'sinatra/assetpack'

Dir['./lib/**/*.rb'].each do |file|
  require file
end

require './app.rb'

run App.new
