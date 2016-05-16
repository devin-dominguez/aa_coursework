require 'colorize'

class Piece
  attr_reader :color, :position

  MOVES = {
    :+ => [ [1,0], [-1,0], [0,1], [0,-1] ],
    :x => [ [1,1], [1,-1], [-1,1], [-1,-1] ],
    :wpm => [ [-1,0] ],
    :bpm => [ [1,0] ],
    :wpc => [ [-1,-1], [-1,1] ],
    :bpc => [ [1,1], [1,-1] ],
    :k => [ [1,2], [1,-2], [2,1], [2,-1], [-1,2], [-1,-2], [-2,1], [-2,-1] ]
  }

  def initialize(color, position = nil)
    @position = position
    @color = color
    @tag = (@color == :black) ? @tag.black : @tag.white
    @max_move_step, @max_capture_step = @max_steps
  end

  def to_s
    @tag
  end

  def deep_dup
    piece_class = self.class
    new_position = @position.dup unless position.nil?
    piece_class.new(@color, new_position)
  end

  def entering_check?(position, board)
    test_board = board.deep_dup_board
    test_piece = test_board[@position]
    test_piece.move(position, test_board)

    enemy_moves = []
    test_board.grid.each do |row|
      row.each do |piece|
        if piece.color != @color
          enemy_moves.concat(piece.check_for_move(test_board, true))
        end
      end
    end

    enemy_moves.uniq.any? do |pos|
      p pos
      test_board[pos].is_a?(King) unless pos.empty?
    end
  end


  def move(position, board)
    previous_position = @position
    @position = position
    board[previous_position]= NullPiece.new
    board[position] = self
  end

  def same_color?(position, board)
    board[position].color == @color
  end

  def in_bounds?(position)
    row, col = position
    row.between?(0,7) && col.between?(0,7)
  end

  def check_path(direction, board, capture)
    steps = capture ? @max_capture_step : @max_move_step

    viable_moves = []
    delta_row, delta_col = direction
    current_row, current_col = @position

    steps.times do |i|
      current_position = [current_row + delta_row * (i+1),
                          current_col + delta_col * (i+1)]

      return viable_moves unless in_bounds?(current_position)

      if same_color?(current_position, board)
        return viable_moves
      else
        unless board[current_position].is_a?(NullPiece)
          viable_moves << current_position if capture
          return viable_moves
        else
          viable_moves << current_position unless capture
        end
      end
    end

    viable_moves
  end

  def check_for_move(board, capture)
    if capture
      direction_symbols = @capture_directions || @directions
    else
      direction_symbols = @directions
    end

    directions = []

    direction_symbols.each do |moveset|
      directions.concat(MOVES[moveset])
    end

    viable_moves = []
    directions.each do |direction|
      viable_moves.concat(check_path(direction, board, capture))
    end

    viable_moves
  end
end
