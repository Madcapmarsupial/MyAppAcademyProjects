class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if num_buckets == @count
      resize!
    end

    if include?(key.hash) == false
      @count += 1
      self[key.hash] << key
      return key
    else
      self[key.hash] << key
    end
    
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if include?(key)
      @count -= 1
      self[key.hash].delete(key)
    end
    nil
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
     @store += Array.new(num_buckets) {Array.new}
    clone = Array.new(num_buckets) {Array.new}
    
    @store.each do |bucket|
      bucket.each do |num|
        clone[num.hash % num_buckets] << num
      end
    end

    @store = clone
  end
end
