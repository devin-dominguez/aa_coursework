require 'rspec'
require 'array_methods'

describe Array do

  describe "Array#my_uniq" do
    subject(:test_array) { [1, 2, 1, 3, 3, 3] }

    it "removes dups" do
      expect(test_array.my_uniq).to eq([1, 2, 3])
    end

    it "does not use built in uniq" do
      expect(test_array).not_to receive(:uniq)
      test_array.my_uniq
    end
  end

  describe "Array#two_sum" do
    subject(:test_array) {[-1,0,2,-2,1]}
    subject(:unmatched_array) {[1,2,3]}

    it "should find positions of pairs that sums to zero" do
      expect(test_array.two_sum).to eq([[0,4],[2,3]])
    end

    it "should return empty array if there are no matches" do
      expect(unmatched_array.two_sum).to eq([])
    end

  end

  describe "Array#my_transpose" do
    subject(:transpose_array) do
      [[0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]]
    end

    it "does not call built in transpose" do
      expect(transpose_array).not_to receive(:transpose)

      transpose_array.my_transpose
    end

    it "will convert between row-oriented and column-oriented representations" do
      expect(subject.my_transpose).to eq(
        [[0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]]
      )
    end
  end

end
