#Contains information about the square
#Provides methods to access this data
class Square
  attr_reader :revealed, :flagged_bomb, :is_a_bomb
  attr_accessor :adj_bombs

  def initialize(is_a_bomb)
    @is_a_bomb = is_a_bomb
    @flagged_bomb = false
    @revealed = false
    @adj_bombs = 0
  end

# unless => !if
# graphically display the square(s) status called from Board class
  def to_s
    img = "F" if flagged_bomb
    img = "*" unless revealed
    if adj_bombs == 0
      img = "_"
    else
      img = "#{adj_bombs}"
    end

    "[ #{img} ]"
  end

  def reveal
    # if !=
    unless @revealed || @flagged_bomb
      @revealed = true
      return @is_a_bomb
    end

    nil
  end

  def flag
    # if !=
    unless @revealed
      if @flagged_bomb == true
        @flagged_bomb = false
      else
        @flagged_bomb = true
      end
    end
  end

end
