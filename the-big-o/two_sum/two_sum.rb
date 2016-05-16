# O(n^2)
def bad_two_sum?(arr,target_sum)
  # O(n^2)
  arr.take(arr.length-1).each_with_index do |el, i| # O(n)
    arr.drop(i + 1).each do |el2| # O(n)
      return true if (el + el2) == target_sum
    end
  end

  false
end

# O(n log(n)) || O(n^2)
def okay_two_sum?(arr,target_sum)
  arr.sort! # O(n log(n)) || O(n^2)

  # O(n log(n))
  arr.each_with_index do |num, i| # O(n)
    compliment = target_sum - num

    bser = arr.drop(i+1).bsearch { |el| compliment-el } # O(log(n))
    return true if bser
  end

  false
end

require 'set'

# O(n)
def hash_two_sum?(arry,target_sum)
  # arry_set = Set.new
  arry_hash = {}

  # O(n)
  arry.each do |num| # O(n)
    compliment = target_sum - num
    return true if arry_hash[compliment] #arry_set[compliment]
    # arry_set << num
    arry_hash[num] = true
  end

  false
end
