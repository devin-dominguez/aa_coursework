# O(n^4)
def lcss_phase_1(list)
  subs = []
  # O(n^2) ~ O(n^3)
  list.each_index do |start_i|
    (start_i...(list.length)).each do |end_i|
      subs << list[start_i..end_i]
    end
  end

  # O((n^2)*n) = O(n^3)
  subs = sum_subsets(subs)
  # O(n^2)
  subs.max
end

# O(nm)
def sum_subsets(list)
  list.map! do |sub|
    sub.inject{ |sum,num| sum + num }
  end
end

# O(n)
def lcss_phase_2(list)
  largest_sum = list.first
  current_contiguous_sum = list.first

  list.drop(1).each do |num|
    if current_contiguous_sum < 0
      current_contiguous_sum = num
    else
      current_contiguous_sum += num
    end

    if current_contiguous_sum > largest_sum
      largest_sum = current_contiguous_sum
    end
  end

  largest_sum
end

#
# [-1, -2, -3]
#
# [3, -2, 3]
#
# 3  cs = 3, ls = 3
# -2 cs = 1, ls = 3
# 3  cs = 4, ls = 4
#
# 3  cs = 3, ls = 3
# -5 cs = -2, ls = 3
# 4  cs = 2 or 4?, ls = 4
