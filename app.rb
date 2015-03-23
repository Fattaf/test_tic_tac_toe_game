class App < Sinatra::Base
  set :server, 'thin'
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
          sleep(1)

          player = open_connection(ws)
          search_game(player)
        end

        ws.onmessage do |msg|
          player  = settings.sockets[ws.object_id]
          result  = player.game.check_play_msg(player, msg)
          give_play_message(player, msg) unless result
        end

        ws.onclose do
          close_connection(ws)
        end

      end
    end
  end

  private
    # on connection create
    def search_game(player)
      new_game = settings.open_games.pop
      return join_game(player, new_game) if new_game
      return create_game(player)
    end

    def create_game(player)
      new_game = Game.new({ player_x: player })
      settings.open_games << new_game
      new_game.send_waiting_msg
      new_game
    end

    def join_game(player, game)
      game.join_player(player)
      game.send_ready_msg
      game
    end

    def open_connection(ws)
      player = Player.new({ socket: ws })
      settings.sockets.merge!({ ws.object_id => player })
      player
    end

    # on connection close
    def close_connection(ws)
      warn("websocket closed")
      player = settings.sockets[ws.object_id]
      player.game.disconnect(player) if player.game
      settings.sockets.delete(ws.object_id)
    end

    # on messaging
    def give_play_message(player, msg)
      EM.next_tick { player.game.send_opponent_msg(player, msg) }
    end

end
