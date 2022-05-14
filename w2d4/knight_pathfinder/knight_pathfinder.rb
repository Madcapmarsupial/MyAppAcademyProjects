require "00_tree_node.rb"

class KnightPathFinder
 
    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        @tree = self.build_move_tree(start_pos)
    end

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
       moves 
    end

    def build_move_tree(pos)
        new_move_positions(pos)
        
    end

    def new_move_positions(pos)
        moves = self.valid_moves(pos).difference(@considered_positions)
        @considered_positions += moves 
        moves
    end
      

end


kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]