require_relative "../piece"

class King < Piece

  def initialize(color, position = nil)
    @tag = '♚'
    @max_steps = [1, 1]
    @directions =[:x, :+]
    super(color, position)
  end

end
