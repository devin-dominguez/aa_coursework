require "rspec"
require "hanoi"

describe Hanoi do
  subject(:hanoi_start) { Hanoi.new }

  describe "Hanoi#render" do
    it "it should render hanoi towers" do
      expect(hanoi_start.render).to eq([[3,2,1],[],[]])
    end
  end

  describe "Hanoi#set_game_state" do
    it "lets you set its game state with an array" do
      hanoi_start.set_game_state([[],[2],[3,1]])
      expect(hanoi_start.render).to eq([[],[2],[3,1]])
    end

    it "should raise an error if argument is invalid" do
      expect { hanoi_start.set_game_state([]) }.to raise_error
      expect { hanoi_start.set_game_state("sting") }.to raise_error
    end

  end

  describe "Hanoi#move" do
    it "raises an Error if destionation our of bound" do
      expect { hanoi_start.move(-1,0) }.to raise_error
      expect { hanoi_start.move(0,4) }.to raise_error
    end

    it "completes move" do
      hanoi_start.move(0,1)
      expect(hanoi_start.render).to eq([[3,2],[1],[]])
    end

    it "raises an error when trying to move from empty tower" do
      expect { hanoi_start.move(1, 2)}.to raise_error
    end

    it "raises an Error when move larger element on smaller element" do
      hanoi_start.move(0, 1)
      expect { hanoi_start.move(0, 1) }.to raise_error
    end
  end

  describe "Hanoi#won?" do
    it "returns true in winning state" do
      hanoi_start.set_game_state([[],[],[3,2,1]])
      expect(hanoi_start.won?).to be true

      hanoi_start.set_game_state([[],[3,2,1], []])
      expect(hanoi_start.won?).to be true
    end

    it "returns false if not in a winning state" do
      hanoi_start.set_game_state([[],[2],[3,1]])
      expect(hanoi_start.won?).to be false
    end

  end

end
