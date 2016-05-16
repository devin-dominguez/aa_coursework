
module CursorInput

  KEYMAP = {
    "w" => :up,
    "a" => :left,
    "s" => :down,
    "d" => :right,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,

    " " => :enter,
    "\r" => :enter,
    "\n" => :enter,

    "\e" => :exit,
    "q" => :exit,
    "\u0003" => :exit
  }

  def get_input
    KEYMAP[read_char]
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getch
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

end
