class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max) {false}
  end

  attr_reader :store, :max
  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max
    raise "Out of bounds" if num < 0
    true
  end

  def validate!(num)
    is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if self.include?(num) == false
      self[num] << num
    end
    nil
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % 20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if self[num].include?(num) == false
      if @count == num_buckets
        resize!
      end
      @count += 1
      self[num] << num
    end
  end

  def remove(num)
    if self[num].include?(num)
      @count -= 1
      return self[num].delete(num)
    end
    nil
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
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
        clone[num % num_buckets] << num
      end
    end

    @store = clone
  end

end
