class Player
  attr_accessor :socket, :game

  def initialize(args = {})
    @socket = args[:socket]
    @game   = args[:game]
  end

end
