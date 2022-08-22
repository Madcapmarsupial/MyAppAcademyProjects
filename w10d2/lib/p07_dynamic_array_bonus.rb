require 'byebug'

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  attr_accessor :count, :start_idx, :store
  include Enumerable

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    # return nil if i >= @count
    # @store[i]

     if i >= @count
      return nil
    elsif i < 0
      return nil if i < -@count
      return self[@count + i]
    end

    @store[(@start_idx + i) % capacity]
  end

  def []=(i, val)
    if i >= @count 
      (i - @count).times { push(nil) }
    elsif i < 0
      return nil if i < -@count
      return self[@count + i] = val
    end

    if i == @count 
      resize! if capacity == @count
      @count += 1
    end

    @store[(@start_idx + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    return false if @count == 0 
    each { |ele| return true if ele == val }
    return false
  end

  def push(val)
    resize! if capacity == @count
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if capacity == @count
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @count += 1
    self
  end

  def pop
    return nil if @count == 0
    idx = @count - 1
    last_item  = @store[(@start_idx + @count - 1) % capacity]
    @count -= 1
    last_item
  end

  def shift
    return nil if @count == 0
    @count -= 1
    first_item = @store[@start_idx]
    @start_idx = (@start_idx + 1) % capacity
    first_item
  end

  def first
    return nil if @count == 0
    @store[@start_idx]
  end

  def last
    return nil if @count == 0
    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    i = 0
    until i == (@count)
      yield self[i]
      i += 1
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    other.each_with_index do |ele, i|
      return false if other[i] != @store[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)

    each_with_index do |ele, i|
      new_store[i] = ele
    end
    @store = new_store
    @start_idx = 0
  end
end
