require_relative 'square'

class Board

  DELTAS = [
          [-1, -1],
          [0, -1],
          [1, -1],
          [-1, 0],
          [1, 0],
          [-1, 1],
          [0, 1],
          [1, 1]
  ]

  def initialize(size = [9, 9])
    @cols, @rows = size
    @grid = []
    populate
  end

  def populate
    @grid = Array.new(@rows) do
      Array.new(@cols) do
        Square.new(true?(20))
      end
    end
  end

  # operator overloading
  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  # adding position element to all elements of DELTA
  # take pos as arg and generate list of places to check
  # take delta and running map on it
  def square_neighbors(pos)
    row, col = pos
    DELTAS.map do |(d_row, d_col)|
      [d_row + row, d_col + col]
    end
  end

  def in_bound?(pos)
    row, col = pos

    row.between?(0, @rows - 1) &&
    col.between?(0, @cols - 1)
  end

  def valid_neighbors(pos)
    square_neighbors(pos).select do |sq_pos|
      in_bound?(sq_pos) && !self[sq_pos].revealed
    end
  end

  def bomb_count(positions)
    bombs = 0
    positions.each do |pos|
      bombs += 1 if self[pos].is_a_bomb
    end
    
    bombs
  end

  def render
    system('clear')

    @grid.each do |row|
      puts row.join
    end
  end

  def true?(prob)
    rand(100) < prob
  end

end
