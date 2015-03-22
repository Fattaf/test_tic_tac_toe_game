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
          data = JSON.parse(msg)
          player = settings.sockets[ws.object_id]

          mark_on_board(player, data)
          check_the_game(player, data, msg)
        end

        ws.onclose do
          close_connection(ws)
        end

      end
    end
  end

  private
    def check_the_game(player, data, msg)
      if player_win?(player, data)
        send_win_move_message(player)
      elsif !player.game.has_moves?
        send_no_moves_message(player)
      else
        # game goes on!
        send_opponent_message(player, msg)
      end
    end

    def send_win_move_message(player)
      message = { status: 'finish', msg: 'You win!' }
      player.socket.send(message.to_json)
      message[:msg] = 'You lose!'
      send_opponent_message(player, message.to_json)
    end

    def send_no_moves_message(player)
      message = { status: 'finish', msg: 'No moves left!' }
      player.socket.send(message)
      send_opponent_message(player, message.to_json)
    end

    def player_win?(player, data)
      pos_x = data['pos_x'].to_i
      pos_y = data['pos_y'].to_i
      player.game.has_win_on_move?(pos_x, pos_y, player)
    end

    def search_game(player)
      new_game = settings.open_games.pop
      return join_game(player, new_game) if new_game
      return create_game(player)
    end

    def create_game(player)
      new_game = Game.new({ player_x: player })
      player.game = new_game
      settings.open_games << new_game
      message = { status: 'pending', msg: 'Game created. Waiting for player.'}.to_json
      player.socket.send(message)
      new_game
    end

    def join_game(player, game)
      player.game = game
      game.player_o = player
      message = { status: 'success', msg: 'Game found.' }.to_json
      game.player_x.socket.send(message)
      game.player_o.socket.send(message)
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

    def mark_on_board(player, data)
      pos_x = data['pos_x'].to_i
      pos_y = data['pos_y'].to_i
      player.game.mark_the_move(pos_x, pos_y, player)
    end

    def close_connection(ws)
      # TODO: delete game!
      warn("websocket closed")

      settings.sockets.delete(ws.object_id)
    end

end

App.run! :port => 3000
