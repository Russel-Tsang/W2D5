require "byebug"
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
  end
end

class LinkedList
  attr_reader :head, :tail

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
    self.head.next == self.tail && self.tail.prev == self.head
    
  end

  def get(key)
    current_node = @head
    until current_node == nil
      if current_node.key == key
        return current_node.val
      else
        current_node = current_node.next
      end
    end
  end

  def include?(key)
    current_node = @head
    until current_node == nil
      if current_node.key == key
        return true
      end
     current_node = current_node.next
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    temp_node = @tail.prev
    @tail.prev = new_node
    temp_node.next = new_node
    new_node.prev = temp_node
    new_node.next = @tail
  end

  def update(key, val)
    current_node = @head
    until current_node == nil
      if current_node.key == key
       current_node.val = val
      end
     current_node = current_node.next
    end
  end

  def remove(key)
    current_node = @head
    until current_node == nil
      if current_node.key == key
       current_node.next.prev = current_node.prev 
       current_node.prev.next = current_node.next
      end
     current_node = current_node.next
    end
  end

  def each(&prc)
    current_node = self.head
    until current_node == nil
      prc.call(current_node) unless current_node.val == nil
     current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
