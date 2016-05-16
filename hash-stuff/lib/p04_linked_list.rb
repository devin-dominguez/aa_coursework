class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.nil?
  end

  def get(key)
    self.each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    self.each { |link| return true if link.key == key }
    false
  end

  def unshift(key, val)
    link = Link.new(key, val)
    link.next = @head

    if empty?
      @tail = Link
    else
      @head.prev = link
    end

    @head = link

    link
  end

  def insert(key, val)
    link = Link.new(key, val)
    link.prev = @tail

    if empty?
      @head = link
    else
      @tail.next = link
    end

    @tail = link

    link
  end

  def remove(key)
    target_link = nil

    self.each do |link|
      if link.key == key
        target_link = link
        break
      end
    end

    raise "Key is not in the link list" if target_link.nil?

    if target_link.prev.nil?
      @head = target_link.next
    else
      target_link.prev.next = target_link.next
    end

    if target_link.next.nil?
      @tail = target_link.prev
    else
      target_link.next.prev = target_link.prev
    end
  end

  def each
    return nil if @head.nil?

    current_link = @head

    until current_link.nil?
      yield(current_link)
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
