require "colorize"
require "io/console"

class Display

attr_reader :cursor
attr_accessor :highlights, :messages

  MOVE_VECTORS = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def initialize
    @cursor = [0, 0]
    @highlights = []
    @messages = ""
  end

  def add_highlights(hl)
    @highlights.concat(hl).uniq!
  end

  def clear_highlights
    @highlights = []
  end

  def render_board(board)
    render_string = ""

    board.grid.each_with_index do |row, row_num|
      render_string << render_row(row, row_num)
      render_string << "\n"
    end

    system("clear")
    puts "WELCOME TO CHESS"
    puts @messages
    puts render_string
    puts "Arrow keys, WASD to move, space or enter to confirm."
  end

  def render_row(row, row_num)
    render_string = ""

    row.each_with_index do |piece, col_num|
      graphic = piece.to_s + " "
      if (row_num + col_num).even?
        graphic = graphic.on_cyan
      else
        graphic = graphic.on_red
      end

      pos = [row_num, col_num]
      if @highlights.any? { |path| path == pos }
        graphic = graphic.on_yellow
      end

      if pos == @cursor
        graphic = graphic.on_green
      end

      render_string << graphic
    end

    render_string
  end

  def move_cursor(direction)
    move = MOVE_VECTORS[direction]
    row, col = @cursor
    d_row, d_col = move

    if (row + d_row).between?(0, 7) && (col + d_col).between?(0, 7)
      @cursor = [row + d_row, col + d_col]
    end
  end



























end
