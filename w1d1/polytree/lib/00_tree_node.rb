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


    
end