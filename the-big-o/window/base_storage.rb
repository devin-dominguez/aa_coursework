class MyStack
  def initialize
    @storage = [[],[],[]] #Actual, #Max, #Min
  end

  def push(item)
    if self.empty?
      max_val = item
      min_val = item
    else
      max_val = @storage[1].last < item ? item : @storage[1].last
      min_val = @storage[2].last > item ? item : @storage[2].last
    end

    @storage[1] << max_val
    @storage[2] << min_val
    @storage[0] << item
  end

  def pop
    @storage[2].pop
    @storage[1].pop
    @storage[0].pop
  end

  def peek
    @storage[0].last
  end

  def empty?
    @storage[0].empty?
  end

  def size
    @storage[0].length
  end

  def max
    @storage[1].last
  end

  def min
    @storage[2].last
  end
end

class MyQueue
  def initialize
    @storage = []
  end

  def enqueue(item)
    @storage << push
  end

  def dequeue
    @storage.shift
  end

  def peak
    @storage.first
  end

  def empty?
    @storage.empty?
  end

  def size
    @storage.length
  end
end
