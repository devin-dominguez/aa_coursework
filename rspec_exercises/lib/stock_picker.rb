def stock_picker(arr)
  return nil if arr.length < 2

  stocks = []
  max = 0
  (arr.length - 1).times do |i|
    j = i + 1

    while j < arr.length
      diff = arr[j] - arr[i]
      if diff > max
        max = diff
        stocks = [i, j ]
      end

      j += 1
    end
  end

  stocks
end
