require_relative "slideable.rb"

class Queen < Piece
    include Slideable
    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        slideable_moves 
    end

    def symbol
        color == "black" ? :♛ : :♕
    end

    private

    def move_dirs
        horizontal_dirs + diagonal_dirs
    end
end