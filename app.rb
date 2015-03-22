require 'thin'
require 'json'
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
      '/js/socket_wrapper.js',
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
        # FIXME: ready message form opponent

        ws.onopen do
          # FIXME: only for test, delete after
          sleep(2)

          player = open_connection(ws)
          search_game(player)
        end

        ws.onmessage do |msg|
          player = settings.sockets[ws.object_id]

          mark_on_board(msg, player)
          send_opponent_message(player, msg)
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

      player.socket.send({ status: 'pending', msg: 'Game created. Waiting for player.'}.to_json)
      new_game
    end

    def join_game(player, game)
      player.game = game
      game.player_o = player
      game.player_x.socket.send({ status: 'success', msg: 'Game found.' }.to_json)
      game.player_o.socket.send({ status: 'success', msg: 'Game found.' }.to_json)
      game
    end

    def open_connection(ws)
      player = Player.new({ socket: ws })
      settings.sockets.merge!({ ws.object_id => player })
      player
    end

    def send_opponent_message(player, msg)
      EM.next_tick {
        opponent = player.game.opponent(player)
        opponent.socket.send(msg)
      }
    end

    def mark_on_board(msg, player)
      data = JSON.parse(msg)
      player.game.mark_from_msg(data)
    end

    def close_connection(ws)
      # TODO: delete game!
      warn("websocket closed")

      settings.sockets.delete(ws.object_id)
    end

end

App.run! :port => 3000
