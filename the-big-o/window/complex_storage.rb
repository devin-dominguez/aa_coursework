require_relative 'base_storage.rb'

class StackQueue
  def initialize
    @storage = MyStack.new
  end

  def dequeue
    reverse_storage
    value = @storage.pop
    reverse_storage
    value
  end

  def enqueue(item)
    @storage.push(item)
  end

  private

  def reverse_storage
    reversed_stack = MyStack.new
    until @storage.empty?
      reversed_stack.push(@storage.pop)
    end
    @storage = reversed_stack
  end
end

class MinMaxStackQueue < StackQueue
  def min
    @storage.min
  end

  def max
    @storage.max
  end
end
