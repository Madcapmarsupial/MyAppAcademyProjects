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
        color == "black" ? :♚ : :♔
    end

    protected

    def move_diffs
       [
        [-1, 0], [1,0], [0,-1], [0, 1],    
        [-1, 1], [1,-1], [-1,-1], [1, 1]
        ]
    end
end
