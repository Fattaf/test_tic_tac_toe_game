require 'thin'
require 'sinatra/base'
require 'sinatra-websocket'
require 'sinatra/assetpack'


class App < Sinatra::Base
  set :server, 'thin'
  set :sockets, []
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets {
    serve '/js',     from: 'assets/javascript'
    # serve '/css',    from: 'assets/css'
    serve '/images', from: 'assets/images'

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    js :app, '/js/app.js', [
      '/js/states/*.js',
      '/js/game.js'
    ]

    # css :application, '/css/application.css', [
    #   '/css/screen.css'
    # ]

    js_compression  :jsmin
    # css_compression :simple
  }

  # routes
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
