class LRUCache
    def initialize(size)
        @store = Array.new(size)
    end

    def count 
        (@store - [nil]).count
    end

    def add(ele)
     if @store.include?(ele)
           i = @store.find_index(ele) 
           return @store << @store.delete_at(i)
     end
        @store.shift
        @store << ele
    end

    def show
        p (@store - [nil])
    end
end

johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  p johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]