class PolyTreeNode

    attr_reader :parent, :value, :children


    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(new_value)
        if self.parent != nil
            @parent.children.delete(self)
        end
        @parent = new_value
        @parent.children << self unless new_value == nil
    end

    def add_child(child_node) 
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "not a child" if !self.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        children.each do |child|  
            result = child.dfs(target_value)
            return result if result != nil
        end
        nil
    end

    def bfs(target_value) 
        queue = []
        queue << self
        until queue.empty?
            node = queue.shift
            return node if node.value == target_value
            queue += node.children
        end
        nil
    end 

   def inspect
        {
            value: self.value,
            children: self.children.length
        }
   end

end