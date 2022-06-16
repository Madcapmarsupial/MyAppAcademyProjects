require_relative "slideable.rb"

class Bishop < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        slideable_moves 
    end

    def symbol
        :B
    end

    private

    def move_dirs
        [[-1, 1], [1,-1], [-1,-1], [1, 1] ]
    end
end