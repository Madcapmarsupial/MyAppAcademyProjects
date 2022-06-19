class Piece
    attr_reader :pos, :color, :board

    def initialize(color=nil, board=nil, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        self.symbol.to_s
    end

    def valid_moves
        moves.reject { |move| move_into_check?(move) }
    end

    

    def symbol
        :X
    end
   
    def empty?
       return self.class == Nullpiece
    end

    def pos=(val)
        @pos = val
    end

    def inspect 
        symbol
    end 

    private
    def move_into_check?(end_pos)
        copy = @board.dup
        copy.move_piece!(@pos, end_pos)
        copy.in_check?(@color)
    end


end

