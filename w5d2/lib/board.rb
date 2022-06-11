require_relative "piece.rb"
require_relative "null_piece.rb"

class Board 
    attr_reader :rows

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        self.populate
    end 

    def populate
        @rows.each_with_index do |row, y|
            row.each_with_index do |square, x|
                if  y < 2 
                    #add_piece
                    @rows[y][x] = Piece.new("white", self, [y, x])
                elsif y > 5 
                    @rows[y][x] = Piece.new("black", self, [y, x])
                else
                    @rows[y][x] = Nullpiece.instance
                end
            end 
        end
    end
        
    def [](pos)
        @rows[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @rows[pos[0]][pos[1]] = val
    end 

    def move_piece(color, start_pos, end_pos)
        raise "no piece here (#{self[start_pos]}) to move" if self[start_pos] == nil
        raise "invalid destination --> #{self[end_pos]}" if self[end_pos].color == color 
        self.move_piece!(color, start_pos, end_pos)
        self[end_pos], self[start_pos] = self[start_pos], Nullpiece.instance
        nil
        
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

    def pieces
    end

    def dup
    end

    def move_piece!(cloor, start_pos, end_pos)
        self[start_pos].pos = end_pos
        

    end

    private 
        @null_piece = Nullpiece.instance


end
