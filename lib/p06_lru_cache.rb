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
    node = @map.get(key)
    if node
      update_link!(node)
      return node.val
    else
      value = @prc.call(key)
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @map.set
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    former_prev = link.prev
    former_next = link.next
    former_next.prev = former_prev
    former_prev.next = former_next
    @store.tail.prev = link
    link.next = @store.tail
  end

  def eject!
  end
end
