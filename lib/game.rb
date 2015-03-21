class Game
  attr_accessor :board, :player_x, :player_o

  def initialize(args = {})
    @board = []
    @player_x = args[:player_x]
    @player_o = args[:player_o]
  end

end
