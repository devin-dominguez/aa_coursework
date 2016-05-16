class Hanoi
  def initialize
    @state = [[3,2,1],[],[]]
  end

  def render
    @state
  end

  def move(pos, dest)
    raise "Out of bounds" unless pos.between?(0, 2) && dest.between?(0, 2)
    raise "Empty starting tower" if @state[pos].empty?
    unless @state[dest].empty? || @state[dest].last > @state[pos].last
      raise "Invalid move"
    end

    @state[dest] << @state[pos].pop
  end

  def set_game_state(state)
    raise "Not an array" unless state.is_a?(Array)
    raise "Invalid input" unless check_input?(state)
    @state = state
  end

  def check_input?(state)
    return false unless state.length == 3
    return false unless state.all? { |el| el.is_a?(Array)}
    return false unless state.flatten.sort == [1,2,3]
    true
  end

  def won?
    @state.drop(1).include?([3, 2, 1])
  end
end
