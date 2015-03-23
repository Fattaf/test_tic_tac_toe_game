class Board
  SIZE = 20
  WIN_LINE_SIZE = 5
  PLAYER_X_SIGN = 1
  PLAYER_Y_SIGN = 0

  attr_accessor :cells

  def initialize()
    @cells = build_board
  end

  def mark_the_move(pos_x, pos_y, sign)
    # sign = give_sign(player)
    cells[pos_x][pos_y] = sign
    cells
  end

  def has_moves?
    cells.each do |row|
      row.each do |element|
        return true unless element
      end
    end
    false
  end

  def has_win_on_move?(pos_x, pos_y, sign)
    # sign = give_sign(player)
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
      SIZE.times do |i|
        new_board[i] = Array.new(SIZE)
      end
      new_board
    end

    def give_edges(pos)
      x = pos - 4 > 0 ? pos - 4 : 0
      y = pos + 4 > SIZE - 1 ? SIZE - 1 : pos + 4
      (x..y)
    end

    # TODO: refactoring !!!

    def x_line_has_win?(edges, pos_y, win_sign)
      counter = 0
      edges.each do |i|
        counter = (cells[i][pos_y] == win_sign) ? counter + 1 : 0
      end
      counter >= WIN_LINE_SIZE
    end

    def y_line_has_win?(edges, pos_x, win_sign)
      counter = 0
      edges.each do |i|
        counter = (cells[pos_x][i] == win_sign) ? counter + 1 : 0
      end
      counter >= WIN_LINE_SIZE
    end

    def diagonal_has_win?(edges_x, edges_y, win_sign)
      counter = 0
      edges_x.each do |i|
        edges_y.each do |j|
          counter = (cells[i][j] == win_sign) ? counter + 1 : 0
        end
      end
      counter >= WIN_LINE_SIZE
    end

end
