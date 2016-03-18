class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashed_value = 1
    each_with_index do |el, idx|
      hashed_value *= (el.hash + idx + 1)
    end
    hashed_value.hash
  end
end

class String
  def hash
    hashed_value = 1
    chars.each_with_index do |char, idx|
      hashed_value *= (char.ord + idx)
    end
    hashed_value.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed_value = 1
    each { |key, val| hashed_value *= (key.to_s.ord + val.to_s.ord) }
    hashed_value.hash
  end
end
