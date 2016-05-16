class Array
  def my_uniq
    arr = []

    self.each do |el|
      arr << el unless arr.include?(el)
    end

    arr
  end

  def two_sum
    arr = []

    self.each_with_index do |i, idx|
      (self.drop(idx+1)).each_with_index do |j, idx2|
        arr << [idx, idx2+idx+1] if i + j == 0
      end
    end

    arr
  end

  def my_transpose
    transposed_array = Array.new(self.length) { Array.new(self.length) }

    self.each_with_index do |row, i|
      row.each_with_index do |value, j|
        transposed_array[j][i] = value
      end
    end

    transposed_array


  end

end
