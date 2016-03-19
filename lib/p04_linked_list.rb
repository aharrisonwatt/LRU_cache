require 'byebug'
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
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = find(key)
    current_node.val
  end

  def include?(key)
    return false if find(key) == @tail
    true
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    last.next = new_link
    new_link.prev = last
    @tail.prev = new_link
    new_link.next = @tail
  end

  def remove(key)
    current_node = find(key)
    previous_node = current_node.prev
    next_node = current_node.next
    previous_node.next = next_node
    next_node.prev = previous_node
  end

  def find(key)
    current_node = first
    until current_node.key == key
      break if current_node == @tail
      current_node = current_node.next
    end
    current_node
  end

  def each
    current_node = first
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
