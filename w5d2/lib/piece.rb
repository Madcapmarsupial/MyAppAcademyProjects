class Piece
    def initialize(pos, color=nil, board=nil )
        @board = board
        @pos = pos
        @symbol = "P"
    end

    def inspect
        @symbol
    end 

end