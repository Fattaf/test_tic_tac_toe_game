class Game
  attr_accessor :board, :player_x, :player_o

  def initialize(args = {})
    @board = []
    @player_x = args[:player_x]
    @player_o = args[:player_o]
  end

  def opponent(player)
    return false unless [player_x, player_o].include?(player)
    player === player_x ? player_o : player_x
  end

end
