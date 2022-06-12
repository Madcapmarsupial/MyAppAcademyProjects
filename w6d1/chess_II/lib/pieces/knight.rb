require_relative "stepable.rb"

class Knight < Piece
    include Stepable

    def initialize(color=nil, board=nil, pos)
        super
    end

    def valid_moves
        moves
    end

    def symbol
        :H
    end

    protected

    def move_diffs
        [[1, 2], [-1, -2], [1, -2], [-1, 2], [2, 1], [-2, -1], [2, -1], [-2, 1]]
    end
end
