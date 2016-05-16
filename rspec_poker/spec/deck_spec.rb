require 'rspec'
require 'Deck'

describe Deck do
  let(:test_deck) { Deck.new(CardDouble) }

  describe "Deck#initialize" do
    it "should have 52 cards" do
      expect(test_deck.cards.length).to eq(52)
    end

    it "should have unique cards" do
      expect(test_deck.cards.uniq.length).to eq(52)
    end
  end

  describe "Deck#shuffle" do
    it "should randomize the cards" do
      previous_state = test_deck.cards.dup
      test_deck.shuffle
      expect(test_deck.cards).not_to eq(previous_state)
    end
  end

  describe "Deck#draw" do
    it "should remove card from Deck on draw" do
      5.times { test_deck.draw }
      expect(test_deck.cards.length).to eq(47)
    end

    it "should raise error when drawing from empty deck" do
      expect { 53.times { test_deck.draw} }.to raise_error
    end

    let(:default_deck) { Deck.new(CardDouble)}
    let(:draw_deck) { Deck.new(CardDouble)}
    it "should return top card of deck" do
      expect(draw_deck.draw).to eq(default_deck.cards.last)
    end
  end

end
