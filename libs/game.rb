class Game
  PLAYER_X_SIGN = 1
  PLAYER_Y_SIGN = 0

  attr_accessor :board, :player_x, :player_o

  def initialize(args = {})
    @board = Board.new()
    join_player(args[:player_x]) if args[:player_x]
    join_player(args[:player_o]) if args[:player_o]
  end

  # helpers
  def join_player(player)
    return false if player_x && player_o
    player.game = self
    return @player_x = player unless player_x
    return @player_o = player unless player_o
  end

  def opponent(player)
    return false unless [player_x, player_o].include?(player)
    player === player_x ? player_o : player_x
  end

  def check_play_msg(player, message)
    pos_x, pos_y = *define_coordinates(JSON.parse(message))
    sign = give_sign(player)
    board.mark_the_move(pos_x, pos_y, sign)

    return send_win_msg(player) if board.has_win_on_move?(pos_x, pos_y, sign)
    return send_no_win_msg unless board.has_moves?
    false
  end

  def disconnect(player)
    send_disconnect_msg(player)
    @player_x.game = nil
    @player_o.game = nil
    @player_x = nil
    @player_o = nil
  end

  # messages
  def send_waiting_msg
    message = { status: 'pending', msg: 'Game created. Waiting for player.' }
    player_x.socket.send(message.to_json)
    true
  end

  def send_ready_msg
    message = { status: 'success', msg: 'Game found.' }
    player_x.socket.send(message.to_json)
    player_o.socket.send(message.to_json)
    true
  end

  def send_win_msg(player)
    message = { status: 'finish', msg: 'You win!' }
    player.socket.send(message.to_json)
    send_lose_msg(opponent(player))
    true
  end

  def send_lose_msg(player)
    message = { status: 'finish', msg: 'You lose!' }
    player.socket.send(message.to_json)
    true
  end

  def send_no_win_msg
    message = { status: 'finish', msg: 'No moves left!' }
    player_x.socket.send(message.to_json)
    player_o.socket.send(message.to_json)
    true
  end

  def send_opponent_msg(player, message)
    opponent_player = opponent(player)
    opponent_player.socket.send(message)
    true
  end

  def send_disconnect_msg(player)
    message = { status: 'finish', msg: 'Player disconnected!' }
    opponent(player).socket.send(message.to_json)
    true
  end

  private
    def give_sign(player)
      return nil unless [player_x, player_o].include?(player)
      player === player_x ? PLAYER_X_SIGN : PLAYER_Y_SIGN
    end

    def define_coordinates(data)
      pos_x = data['pos_x'].to_i
      pos_y = data['pos_y'].to_i
      [pos_x, pos_y]
    end
end
