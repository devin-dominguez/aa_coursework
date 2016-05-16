require_relative 'board'
require_relative 'player'
require_relative 'square'

class Game

  def initialize(board)
    @board = board
  end

  def play
  end

  def check_position(pos)
    #TODO check if pos is a bomb and return if it is

    queue = [pos]

    until queue.empty?
      current_pos = queue.shift
      current_sqr = @Board[current_pos]
      current_sqr.reveal

      adjacent_positions = @Board[current_pos].valid_neighbors
      current_sqr.adj_bombs = @Board.bomb_count(adjacent_positions)



    end



  end

end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  game = Game.new(board)
  game.play

end
