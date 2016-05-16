require_relative 'Card'

class Deck
  attr_reader :cards

  def initialize(card_class = Card) #TODO remove arg from production version
    @cards = []
    populate_deck(card_class)
  end

  def shuffle
    @cards.shuffle!
  end

  def draw
    raise "Not enough cards" if @cards.empty?

    @cards.pop

  end

  private

  def populate_deck(card_class = Card)
    suites = Card::SUITES.keys
    values = Card::STRING_VALUES.keys
    values.product(suites).each do |card|
      @cards << card_class.new(card[0], card[1])
    end
  end

end
