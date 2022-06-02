require_relative "piece.rb"

class Board

   def self.populate(arr)
    arr.each_with_index do |row, y|
        row.each_with_index do |square, x|
            if  y < 2 || y > 5 
                arr[y][x] = Piece.new([y, x])
            else
                arr[y][x] = nil
            end
        end 
   end

   end 

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        Board.populate(@rows)
    end 
        
    def [](pos)
        @rows[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @rows[pos[0]][pos[1]] = val
    end 

    def move_piece(color=nil, start_pos, end_pos)
        piece = self[start_pos]
        raise "no piece here to move --> #{self[start_pos]}" if piece == nil
        raise "invalid destination --> #{self[end_pos]}" if self[end_pos] != nil 
        self[end_pos], self[start_pos] = piece, nil #nullpiece
        

    end

    def valid_pos?(pos)
    end

    def add_piece(piece, pos)
    end

    def checkmate?(color)
    end

    def in_check?(color)
    end 

    def in_check?(color)
    end

    def find_king(color)
    end

    def pieced
    end

    def dup
    end

    def move_piece!(color, start_pos, end_pos)
    end

    private 
        #@null_piece = NullPiece.new


end

p Board.new