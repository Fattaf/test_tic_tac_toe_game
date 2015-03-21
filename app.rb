require 'thin'
require 'sinatra/base'
require 'sinatra-websocket'
require 'sinatra/assetpack'

require './lib/game.rb'
require './lib/player.rb'
# TODO: config.ru

class App < Sinatra::Base
  set :server, 'thin'
  # FIXME: sockets == players
  set :sockets, {}
  set :open_games, []
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  assets {
    serve '/js',     from: 'assets/javascript'
    # serve '/css',    from: 'assets/css'
    serve '/images', from: 'assets/images'

    js :app, '/js/app.js', [
      '/js/websocket.js',
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
        # TODO: on error

        ws.onopen do
          # FIXME: delete
          sleep(2)

          player = open_connection(ws)
          search_game(player)
        end

        ws.onmessage do |msg|
          send_message(msg)
        end

        ws.onclose do
          close_connection(ws)
        end
      end
    end
  end

  private
    def search_game(player)
      new_game = settings.open_games.pop
      return join_game(player, new_game) if new_game
      return create_game(player)
    end

    def create_game(player)
      new_game = Game.new({ player_x: player })
      player.game = new_game
      settings.open_games << new_game

      player.socket.send('Game created. Searching other player.')
      new_game
    end

    def join_game(player, game)
      player.game = game
      game.player_o = player
      game.player_o.socket.send('Game found.')
      game.player_x.socket.send('Game found.')
      game
    end

    def open_connection(ws)
      player = Player.new({ socket: ws })
      settings.sockets.merge!({ ws.object_id => player })
      player
    end

    def send_message(msg)
      # FIXME: not all sockets!!!
      # EM.next_tick { settings.sockets.values.each{|player| player.socket.send(msg) } }
    end

    def close_connection(ws)
      # TODO: may be delete game!
      warn("websocket closed")
      settings.sockets.delete(ws.object_id)
    end

end

App.run! :port => 3000
