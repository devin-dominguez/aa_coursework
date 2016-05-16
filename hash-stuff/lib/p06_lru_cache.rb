require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    return calc!(key) unless @map.include?(key)

    target_link = @map.get(key)
    update_link!(target_link)
    target_link.val

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)

    eject! if @map.count == @max
    link = @store.insert(key, val)
    @map[key] = link

    return val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    oldest_key = @store.first.key
    @store.remove(oldest_key)
    @map.delete(oldest_key)
  end

end
