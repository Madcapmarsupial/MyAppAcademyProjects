require_relative "slideable.rb"

class Queen < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        slideable_moves #(move_dirs, self)
    end

    def symbol
        :Q
    end

    private

    def move_dirs
        #up down left
        [
            [-1, 0], [1,0], [0,-1], [0, 1],    
            [-1, 1], [1,-1], [-1,-1], [1, 1]
        ]
        #diagonals
    end
end