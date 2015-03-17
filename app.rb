require 'thin'
require 'sinatra/base'
require 'sinatra-websocket'


class App < Sinatra::Base
  set :server, 'thin'
  set :sockets, []

  get '/' do
    unless request.websocket?
      erb :index
    else
      request.websocket do |ws|

        ws.onopen do
          ws.send("Hello World!")
          settings.sockets << ws
        end

        ws.onmessage do |msg|
          # FIXME: all!!!
          EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
        end

        ws.onclose do
          warn("websocket closed")
          settings.sockets.delete(ws)
        end

      end
    end
  end

end

App.run! :port => 3000
