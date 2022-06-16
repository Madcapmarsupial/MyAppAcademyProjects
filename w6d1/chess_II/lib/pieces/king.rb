require_relative "stepable.rb"

class King < Piece
    include Stepable

    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        stepable_moves
    end

    def symbol
        :K
    end

    protected

    def move_diffs
       #up down left
       [
        [-1, 0], [1,0], [0,-1], [0, 1],    
        [-1, 1], [1,-1], [-1,-1], [1, 1]
        ]
    #diagonals
    end
end
