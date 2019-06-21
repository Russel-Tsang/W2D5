class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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

  def include?(num)
    self[num].include?(num)
  end

  def remove(num)
    return unless self[num].include?(num)
    self[num].delete(num)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num.hash % num_buckets
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
