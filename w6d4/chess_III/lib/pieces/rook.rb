require_relative "slideable.rb"

class Rook < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        slideable_moves 
    end

    def symbol
        :R
    end

    private

    def move_dirs
        horizontal_dirs
    end
end