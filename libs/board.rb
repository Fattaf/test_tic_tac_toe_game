class Board
  SIZE = 20
  WIN_LINE_SIZE = 5

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
    return true if x_y_diagonal_has_win?(sign, pos_x, pos_y)
    return true if y_x_diagonal_has_win?(sign, pos_x, pos_y)
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

    def x_line_has_win?(edges, pos_y, win_sign)
      final_size, counter = 0, 0
      edges.each do |i|
        counter += 1          if cells[i][pos_y] == win_sign
        final_size = counter  if counter > final_size
        counter = 0           if cells[i][pos_y] != win_sign
      end
      final_size >= WIN_LINE_SIZE
    end

    def y_line_has_win?(edges, pos_x, win_sign)
      final_size, counter = 0, 0
      edges.each do |i|
        counter += 1          if cells[pos_x][i] == win_sign
        final_size = counter  if counter > final_size
        counter = 0           if cells[pos_x][i] != win_sign
      end
      final_size >= WIN_LINE_SIZE
    end

    def x_y_diagonal_has_win?(win_sign, pos_x, pos_y)
      diff = pos_x - pos_y
      new_y = diff >= 0 ? 0 : -diff
      new_x = diff >= 0 ? diff : 0

      final_size, counter = 0, 0
      (SIZE - diff.abs).times do |i|
        counter += 1          if cells[new_x + i][new_y + i] == win_sign
        final_size = counter  if counter > final_size
        counter = 0           if cells[new_x + i][new_y + i] != win_sign
      end
      final_size >= WIN_LINE_SIZE
    end

    def y_x_diagonal_has_win?(win_sign, pos_x, pos_y)
      diff = (SIZE - 1 - pos_x) - pos_y
      new_y = diff >= 0 ? 0 : SIZE - 1
      new_x = diff >= 0 ? SIZE - 1 - diff.abs : diff.abs

      final_size, counter = 0, 0
      (SIZE - diff.abs).times do |i|
        counter += 1          if cells[new_x - i][new_y + i] == win_sign
        final_size = counter  if counter > final_size
        counter = 0           if cells[new_x - i][new_y + i] != win_sign
      end
      final_size >= WIN_LINE_SIZE
    end
end
