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
    edges_x = give_edges(pos_x)
    edges_y = give_edges(pos_y)

    return true if y_line_has_win?(edges_y, pos_x, sign)
    return true if x_line_has_win?(edges_x, pos_y, sign)
    return true if x_y_diagonal_has_win?(edges_x, edges_y, sign)
    return true if y_x_diagonal_has_win?(edges_x, edges_y, sign)
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
      final_size, counter = 0, 0
      edges.each do |i|
        if cells[i][pos_y] == win_sign
          counter += 1
        else
          final_size = counter if counter > final_size
          counter = 0
        end
      end
      final_size >= WIN_LINE_SIZE
    end

    # TODO: refactoring !!!
    def y_line_has_win?(edges, pos_x, win_sign)
      final_size, counter = 0, 0
      edges.each do |i|
        if cells[pos_x][i] == win_sign
          counter += 1
        else
          final_size = counter if counter > final_size
          counter = 0
        end
      end
      final_size >= WIN_LINE_SIZE
    end

    # TODO: refactoring !!!
    def x_y_diagonal_has_win?(edges_x, edges_y, win_sign)
      # final_size = 0
      # counter = 0
      # x = edges_x.first
      # y = edges_y.first

      # 9.times do |i|
      #   if cells[x + i][y + i] == win_sign
      #     counter += 1
      #   else
      #     final_size = counter if counter > final_size
      #     counter = 0
      #   end
      # end
      # final_size >= WIN_LINE_SIZE
      false
    end

    def y_x_diagonal_has_win?(edges_x, edges_y, win_sign)
      # final_size = 0
      # counter = 0
      # x = edges_x.last
      # y = edges_y.first

      # p [x, y]

      # 9.times do |i|
      #   p [x - i, y + i]
      #   p cells[x - i][y - i]

      #   if cells[x - i][y - i] == win_sign
      #     counter += 1
      #   else
      #     final_size = counter if counter > final_size
      #     counter = 0
      #   end
      # end
      # final_size >= WIN_LINE_SIZE
      false
    end
end
