class Game
  attr_accessor :board, :player_x, :player_o

  def initialize(args = {})
    @board = build_board
    @player_x = args[:player_x]
    @player_o = args[:player_o]
  end

  def opponent(player)
    return false unless [player_x, player_o].include?(player)
    player === player_x ? player_o : player_x
  end

  def mark_from_msg(data)
    pos_x = data['pos_x'].to_i
    pos_y = data['pos_y'].to_i
    board[pos_x][pos_y] = 1;
    board
  end

  private
    def build_board
      Array.new(20, Array.new(20))
    end

end
