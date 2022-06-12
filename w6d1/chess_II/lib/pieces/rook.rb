require_relative "slideable.rb"

class Rook < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def valid_moves
        moves #(move_dirs, self)
    end

    def symbol
        :R
    end

    private

    def move_dirs
        [[-1, 0], [1,0], [0,-1], [0, 1] ]
        #up down left
    end
end