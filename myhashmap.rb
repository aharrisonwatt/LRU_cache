class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max) {false}
  end

  def insert(el)
    @store[el] = true
  end

  def remove(el)
    @store[el] = false
  end

  def include?(el)
    @store[el] == true
  end
end
