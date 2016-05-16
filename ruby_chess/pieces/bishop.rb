require_relative "../piece"

class Bishop < Piece

  def initialize(color, position = nil)
    @tag = '♝'
    @max_steps = [7, 7]
    @directions =[:x]
    super(color, position)
  end

end
