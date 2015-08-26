require "rspec"
require "array"

describe Array do
  subject(:my_array) { [1,1,2,2,3,3,-1,0,-2] }

  describe "#my_uniq" do
    it "returns uniq elements of the array" do
      expect(my_array.my_uniq).to eq([1,2,3,-1,0,-2])
    end
  end

  describe "#two_sum" do
    it "should find pairs of positions where sum equal zero." do
      expect(my_array.two_sum).to eq([[0, 6], [1, 6], [2, 8], [3, 8]])
    end
  end

  describe "#median" do
    let(:arr2) { [2, 4, 6, 8] }
    let(:empty_array) { [] }
    it "should find median of a given array" do
      expect(my_array.sort.median).to eq(1)
    end

    it "should return average for even length arrays" do
      expect(arr2.median).to eq(5)
    end

    it "should raise an error for empty array" do
      expect do
        empty_array.median
      end.to raise_error
    end
  end

  describe "#my_transpose" do
    let(:matrix) {[
                  [0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8] ]}

    it "should transpose the 2d array" do
      expect(matrix.my_transpose).to eq(matrix.transpose)
    end

    it "doesn't change original array" do
      original = matrix.dup
      matrix.my_transpose
      expect(matrix).to eq(original)
    end

  end

end
