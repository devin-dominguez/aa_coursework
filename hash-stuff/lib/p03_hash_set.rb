require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    resize! if need_to_resize?

    self[key] << key unless include?(key)
  end

  def include?(key)
    self[key].include? (key)
  end

  def remove(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def need_to_resize?
    num_buckets < @count
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(num_buckets * 2) { Array.new }

    @count = 0
    old_store.each do |bucket|
      bucket.each{ |el| self.insert(el) }
    end

  end


end
