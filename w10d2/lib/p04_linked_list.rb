

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = self.prev
    @prev.next = self.next 
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each do |node| 
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    return get(key) != nil
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    (@tail.prev).next = node
    @tail.prev = node
    node.next = @tail
  end

  def update(key, val)
    self.each do |node|
      if node.key == key 
        node.val = val
        return val
      end
    end
    nil
  end

  def remove(key)
      self.each do |node|
      if node.key == key 
        node.remove
        return node
      end
    end
    nil
  end
  # list.each do |node|  end
  def each
    if block_given?
      node = @head.next
      until node == @tail
        yield node
        node = node.next
      end
      node
    end
  end


  # uncomment when you have `each` working and `Enumerable` included
   def to_s
     inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
   end
end
