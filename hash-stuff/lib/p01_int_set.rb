class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)

    @store[num] = true
  end

  def remove(num)
    validate!(num)

    @store[num] = false
  end

  def include?(num)
    validate!(num)

    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = find_bucket(num)
    self[bucket] << num unless include?(num)
  end

  def remove(num)
    bucket = find_bucket(num)
    self[bucket].delete(num)
  end

  def include?(num)
    bucket = find_bucket(num)
    self[bucket].include? (num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def find_bucket(num)
    num % num_buckets
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if need_to_resize?

    bucket = find_bucket(num)
    self[bucket] << num unless include?(num)
  end

  def remove(num)
    bucket = find_bucket(num)
    self[bucket].delete(num)

    @count -= 1
  end

  def include?(num)
    bucket = find_bucket(num)
    self[bucket].include? (num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(num_buckets * 2)
    @store.each do |bucket|
      bucket.each { |el| new_set.insert(el) }
    end


    @store = new_set.store
  end

  def need_to_resize?
    num_buckets < @count
  end

  def find_bucket(num)
    num % num_buckets
  end

  protected
  attr_reader :store
end
