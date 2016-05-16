require_relative "../piece"

class NullPiece < Piece

  def initialize(color = nil, position = nil)
    @color = color
    @tag = ' '
  end

  def check_for_move(board, capture)
    []
  end

end
