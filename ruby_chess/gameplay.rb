require_relative "cursor_input"
require_relative "display"
require_relative "board"

class GamePlay

  attr_reader :turn, :board
  attr_accessor :won

  extend CursorInput

  def initialize
    @board = Board.new
    @display = Display.new
    @won = false
    @selected_piece = nil
    @turn = :white

    @board.pop_board
  end

  def run
    until @won
      display_turn
      @display.render_board(@board)
      input = self.class.get_input
      handle_command(input)
    end
  end

  def inspect_piece(position)
    puts "#{@board[position]} #{@board[position].color}"
  end

  def handle_command(command)

    case command
    when :exit
      @won = true
    when :enter
      position = @display.cursor
      handle_enter(position)
    when :left, :right, :up, :down
      @display.move_cursor(command)
    else
      puts command
    end
  end

  def swap_player
    @turn = (@turn == :black) ? :white : :black
  end

  def display_turn
    @display.messages = "#{@turn.to_s}'s turn"
  end


  def handle_enter(position)
    if @selected_piece.nil?
      select_piece(position)
    elsif @selected_piece == @board[position]
      deselect_piece
    else
      attempt_to_move(position)
    end
  end

  def valid_selection?(position)
    @turn == @board[position].color
  end

  def select_piece(position)
    if valid_selection?(position)
      @selected_piece = @board[position]

      captures = @board[position].check_for_move(@board, true)
      moves = @board[position].check_for_move(@board, false)

      @display.add_highlights([position] + captures + moves)
    end
  end

  def deselect_piece
    @selected_piece = nil
    @display.clear_highlights
  end

  def attempt_to_move(position)
    previous_position = @selected_piece.position

    captures = @board[previous_position].check_for_move(@board, true)
    moves = @board[previous_position].check_for_move(@board, false)

    valid_moves = captures.concat(moves)
    valid_moves.reject! { |move| @selected_piece.entering_check?(move, @board)}
    if valid_moves.any? { |move| move == position }
      @selected_piece.move(position, board)

      swap_player
    end

    deselect_piece
  end
end
