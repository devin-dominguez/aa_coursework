require "rspec"
require "card"
require "colorize"

describe Card do
  let(:new_card) { Card.new(:king, :clubs) }

  describe "Card#value" do
    it "should return value" do
      expect(new_card.value).to eq(:king)
    end
  end

  describe "Card#suite" do
    it "should return suite" do
      expect(new_card.suite).to eq(:clubs)
    end
  end

  describe "Card#to_s" do
    it "should return string representation of value and suite" do
      expect(new_card.to_s).to eq("K ♣".blue)
    end
  end

  describe "Card.numeric_value" do
    describe "should return numeric value of card" do
      it "should return numeric value of number card" do
          expect(Card.numeric_value(2)).to eq(2)
      end

      it "should return numeric value of face card" do
        expect(Card.numeric_value(:king)).to eq(13)
      end

    end
  end

end
