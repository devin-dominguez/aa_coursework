require_relative "../piece"

class Knight < Piece

  def initialize(color, position = nil)
    @tag = '♞'
    @max_steps = [1, 1]
    @directions =[:k]
    super(color, position)
  end

end
