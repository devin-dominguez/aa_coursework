# O(n^3)
def first_anagram?(word,goal)
  chars = word.split("")
  anagrams = chars.permutation.to_a # O(n^2)
  anagrams.map! { |word| word.join } # O(n^3)
  anagrams.include?(goal) # O(n)
end

# O(n^2)
def second_anagram?(word,goal)
  word = word.split("") # O(n)
  goal = goal.split("") # O(n)
  test_word = word.dup # O(n)

  # O(n^2)
  test_word.each do |char|
    if goal.include?(char) # O(n)
      delete_first!(char,goal) # O(n)
      delete_first!(char,word) # O(n)
    end
  end
  # O(n) + O(n)
  word.empty? && goal.empty?
end

# O(n)
def delete_first!(char,word)
  char_index = word.index(char) # O(n)
  word.delete_at(char_index) unless char_index.nil? #O(1)
end

# O(n^2) || O(n log(n))
def third_anagram?(word, goal)
  word = word.split('') # O(n)
  goal = goal.split('') # O(n)
  # O(n^2) + O(n^2) || O(n log(n)) + O(n log(n))
  word.sort == goal.sort
end

def fourth_anagram?(word, goal)
  word_freq = Hash.new(0)
  goal_freq = Hash.new(0)

  word.each_char { |char| word_freq[char] += 1 } # O(n)
  goal.each_char { |char| goal_freq[char] += 1 } # O(n)


  word_freq == goal_freq
end

# O(n)
def bonus_anagram?(word, goal)
  word_freq = Hash.new(0)

  word.each_char { |char| word_freq[char] += 1 } # O(n)
  goal.each_char { |char| word_freq[char] -= 1 } # O(n)

  word_freq.values.all? { |value| value == 0} # O(n)
end
