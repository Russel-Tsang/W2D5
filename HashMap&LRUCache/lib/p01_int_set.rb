require "byebug"
class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    return false if include?(num)
    if num > @max || num < 0 
      raise "Out of bounds"
    else  
      @store[num] = true 
    end
   
  end

  def remove(num)
    @store[num] = !@store[num]
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % num_buckets
    @store[index] 
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count + 1 > num_buckets
      resize!
    end
    unless self[num].include?(num)
      self[num] << num 
      @count += 1  
    end
    
  end

  def remove(num)
    return unless self[num].include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % num_buckets
    @store[index] 
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    @store = Array.new(old_store.count * 2) { Array.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |ele|
        self.insert(ele)
      end
    end
  end
end
