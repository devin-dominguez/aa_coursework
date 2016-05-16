class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count, :capacity

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @capacity = capacity
  end

  def [](i)
    puts @count
    return nil if i >= count
    i = @count + i if i < 0
    return nil if i < 0

    @store[i]
  end

  def []=(i, val)

    until i < capacity
      resize!
    end

    @store[i] = val
    @count = i + 1 if i >= @count
  end

  # def capacity
  #   @store.length
  # end

  def include?(val)
    self.each do |el|
      return true if el == val
    end

    false
  end

  def push(val)
    self[@count] = val
  end

  def unshift(val)
  end

  def pop
    return nil if @count == 0
    val = self[@count - 1]
    self[@count - 1] = nil
    @count -= 1

    val
  end

  def shift
  end

  def first
    @store[0]
  end

  def last
    @store[ @count - 1 ]
  end

  def each
    @count.times do |i|
      yield @store[i]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store = @store
    @capacity *= 2
    @store = StaticArray.new(@capacity)

    @count.times do |i|
      @store[i] = old_store[i]
    end

  end
end
