require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
    bucket(key).insert(key, val)
    @count += 1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each(&prc)
    prc ||= Proc.new { |k, v| puts k + v }
    @store.each do |list|
      list.each do |node|
        key = node.key
        val = node.val
        prc.call(key, val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    old_store.each do |list|
      list.each do |node|
        set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
