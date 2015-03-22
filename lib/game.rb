class Game
  SIZE = 20
  WIN_LINE_SIZE = 5
  PLAYER_X_SIGN = 1
  PLAYER_Y_SIGN = 0

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

  def mark_the_move(pos_x, pos_y, player)
    sign = give_sign(player)
    @board[pos_x][pos_y] = sign
    board
  end

  def has_moves?
    board.each do |row|
      row.each do |element|
        return true unless element
      end
    end
    false
  end

  def has_win_on_move?(pos_x, pos_y, player)
    sign = give_sign(player)
    edges_x = give_edges(pos_x)
    edges_y = give_edges(pos_y)

    return true if y_line_has_win?(edges_y, pos_x, sign)
    return true if x_line_has_win?(edges_x, pos_y, sign)
    return true if diagonal_has_win?(edges_x, edges_y, sign)
    return true if diagonal_has_win?(edges_x.to_a.reverse, edges_y, sign)
    false
  end

  private
    def build_board
      new_board = Array.new(SIZE)
      SIZE.times{|i| new_board[i] = Array.new(SIZE) }
      new_board
    end

    def give_sign(player)
      return nil unless [player_x, player_o].include?(player)
      player === player_x ? PLAYER_X_SIGN : PLAYER_Y_SIGN
    end

    def give_edges(pos)
      x = pos - 4 > 0 ? pos - 4 : 0
      y = pos + 4 > SIZE - 1 ? SIZE - 1 : pos + 4
      (x..y)
    end

    # TODO: refactoring
    def x_line_has_win?(edges, pos_y, win_sign)
      counter = 0
      edges.each do |i|
        counter = (board[i][pos_y] == win_sign) ? counter + 1 : 0
      end
      counter >= WIN_LINE_SIZE
    end

    def y_line_has_win?(edges, pos_x, win_sign)
      counter = 0
      edges.each do |i|
        counter = (board[pos_x][i] == win_sign) ? counter + 1 : 0
      end
      counter >= WIN_LINE_SIZE
    end

    def diagonal_has_win?(edges_x, edges_y, win_sign)
      counter = 0
      edges_x.each do |i|
        edges_y.each do |j|
          counter = (board[i][j] == win_sign) ? counter + 1 : 0
        end
      end
      counter >= WIN_LINE_SIZE
    end

end
