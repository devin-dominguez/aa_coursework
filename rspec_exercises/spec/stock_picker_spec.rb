require "rspec"
require "stock_picker"

describe "StockPicker" do
  subject(:stock) {[4,3,1,2,5,7,8,5,3,7,10]}
  subject(:short_stock) {[1]}

  it "outputs the most profitable pair of days" do
    expect(stock_picker(stock)).to eq([2,10])
  end

  it "return nil if array length is less than 2" do
    expect(stock_picker(short_stock)).to be_nil
  end

end
