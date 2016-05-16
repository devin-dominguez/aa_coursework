# O(n^2)
def my_min_phase_1(list)
  list.each do |item_a|
    return item_a if list.all? { |item_b| item_a <= item_b }
  end
end

# O(n)
def my_min_phase_2(list)
  min = list.first
  list.drop(1).each do |item|
    min = item if item < min
  end

  min
end
