require 'colorize'

class Card
  attr_reader :value, :suite

  SUITES = {
    clubs:"♣",
    diamonds:"♦",
    hearts:"♥",
    spades:"♠"
  }

  STRING_VALUES = {
    # 1:"A"
    2 => "2 ",
    3 => "3 ",
    4 => "4 ",
    5 => "5 ",
    6 => "6 ",
    7 => "7 ",
    8 => "8 ",
    9 => "9 ",
    10 => "10",
    jack: "J ",
    queen: "Q ",
    king: "K ",
    ace: "A  "
  }

  VALUE = (2..14).to_a

  def initialize(value, suite)
    @value = value
    @suite = suite

  end

  def to_s
    display = STRING_VALUES[@value] + SUITES[@suite] 
    if [:clubs, :spades].include?(@suite)
      display.blue
    else
      display.red
    end
  end


  def self.numeric_value(value)
    index = STRING_VALUES.keys.index(value)
    VALUE[index]
  end


end
