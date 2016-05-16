# O(n)
def windowed_max_range(array, window_size)
  max_range = nil
  x = 0
  (array.length - window_size + 1).times do |start| #length+1-window_size
    window = array[start, window_size]
    min_val = window.min #window size
    max_val = window.max #window size
    diff = max_val - min_val
    max_range ||= diff
    max_range = diff if max_range < diff
    x = start
  end
  puts x
  max_range
end

require_relative 'complex_storage.rb'
# O(n)
def minmaxstackqueue_window(array, window_size)
  crazy_stack_queue = MinMaxStackQueue.new
  window_size.times { crazy_stack_queue.enqueue(array.shift) }
  diff = crazy_stack_queue.max - crazy_stack_queue.min

  until array.empty?
    crazy_stack_queue.dequeue # O(n)
    crazy_stack_queue.enqueue(array.shift)
    new_diff = crazy_stack_queue.max - crazy_stack_queue.min
    diff = new_diff if new_diff > diff
  end

  diff
end
