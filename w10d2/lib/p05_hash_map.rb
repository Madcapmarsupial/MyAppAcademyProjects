require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if bucket(key) == nil
    bucket(key).include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
     return bucket(key).update(key, val)
    else
      @count += 1
      if @count == num_buckets
        resize!
      end
     return bucket(key).append(key, val)
    end
  end

  def get(key)
     return bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key) 
      @count -= 1
    end
    nil
  end

  include Enumerable

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
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
    clone = Array.new(num_buckets*2) {LinkedList.new}

    self.each do |k, v|
        clone[k.hash % (num_buckets*2)].append(k, v)
    end

    @store = clone
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
