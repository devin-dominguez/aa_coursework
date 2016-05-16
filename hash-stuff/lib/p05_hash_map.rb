require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
      self.delete(key) if self.include?(key)

      @count += 1
      resize! if need_to_resize?
      bucket(key).insert(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1
    bucket(key).remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each{ |link| yield(link.key, link.val)}
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(num_buckets * 2) { LinkedList.new }

    @count = 0
    old_store.each do |bucket|
      bucket.each { |link| self.set(link.key, link.val) }
    end
  end

  def need_to_resize?
    num_buckets < @count
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
