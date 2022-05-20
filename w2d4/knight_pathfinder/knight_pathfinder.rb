require_relative "00_tree_node.rb"
require 'byebug'

class KnightPathFinder
 
    def self.valid_moves(pos)
        moves = [
            [2, 1], [2, -1], [-2, -1], 
            [-2, 1], [1, 2], [1, -2],
            [-1, 2], [-1, -2]
        ]
  
        moves.map! do |pair|
            pair[0] += pos.first
            pair[1] += pos.last
            pair
        end
        #check for boundries
        moves.select!{ |pair| pair.all? {|num| num > -1 && num < 9} } || moves
    end

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]

        self.build_move_tree(@root_node)
    end


    def new_move_positions(pos)
        all_moves = KnightPathFinder.valid_moves(pos)
        moves = all_moves - @considered_positions
        @considered_positions += moves 
        moves
    end

    def build_move_tree(root_node)
        #move_list = new_move_positions(node.valid_moves)
        
        queue = []
        queue << root_node
        until queue.empty?
            node = queue.shift
            children = new_move_positions(node.value)
            children.map! { |pos| PolyTreeNode.new(pos) }
            children.each { |child| node.add_child(child) }
            queue += children
            #turn them to nodes
            #mark them as children
            #add them to queue 

            #return node if node.value == target_value
            queue += node.children
        end
        nil
    end

    def root
        @root_node
    end

    def find_path(end_pos)
        target = @root_node.bfs(end_pos)
        trace_path_back(target)
    end
    
    def trace_path_back(end_node)
        last_step = end_node
        positions = [last_step]
        until last_step == @root_node
            last_step = last_step.parent
            positions.unshift(last_step)
        end
        positions
    
    end



    def inspect
        {
          root: @root_node.value,
          children: @root_node.children
        }
    end 
      

end


kpf = KnightPathFinder.new([0, 0])
#p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
#p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]