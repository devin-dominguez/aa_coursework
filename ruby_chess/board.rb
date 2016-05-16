require_relative "pieces_manifest"

class Board
  attr_accessor :grid

  PIECES = [
    Rook,
    Knight,
    Bishop,
    King,
    Queen,
    Bishop,
    Knight,
    Rook
  ]



  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.new}}
  end

  def pop_board
    @grid[0].each_index do |i|
      grid[0][i] = PIECES[i].new(:black, [0, i])
    end

    @grid[7].each_index do |i|
      grid[7][i] = PIECES[i].new(:white, [7, i])
    end

    @grid[1].each_index { |i | grid[1][i] = Pawn.new(:black, [1, i]) }
    @grid[6].each_index { |i | grid[6][i] = Pawn.new(:white, [6, i]) }


  end

  def deep_dup_board
    new_board = Board.new
    new_grid = @grid.map do |row|
      row.map do |el|
        el.deep_dup
      end
    end
    new_board.grid = new_grid
    new_board
  end

  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    @grid[row][col] = value
  end

end
