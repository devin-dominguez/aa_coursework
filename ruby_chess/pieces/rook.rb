require_relative "../piece"

class Rook < Piece
  def initialize(color, position = nil)
    @tag = '♜'
    @max_steps = [7, 7]
    @directions =[:+]
    super(color, position)
  end

end
