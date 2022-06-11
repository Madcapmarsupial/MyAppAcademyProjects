require_relative "slideable.rb"

class Bishop < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def valid_moves
        moves 
    end

    def symbol
        :B
    end

    private

    def move_dirs
        [[-1, 1], [1,-1], [-1,-1], [1, 1] ]
        #up down left
    end
end