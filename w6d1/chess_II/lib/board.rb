require_relative "pieces.rb"
require 'byebug'

class Board 
    attr_reader :rows

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        self.populate
    end 

    def populate
        (2..5).each { |y| (0..7).each { |x| self[[y,x]] = Nullpiece.instance } }
        set_pieces("white")
        set_pieces("black")
    end
        
    def set_pieces(color)
        color == "white" ? (y1, y2 = 0, 1) : (y1, y2 = 7, 6)
        (0..7).each do |x|
            self[[y2, x]] = Pawn.new(color, self, [y2, x])
            case x 
            when 0 
                self[[y1, x]] = Rook.new(color, self, [y1, x])
            when 1
                self[[y1, x]] = Knight.new(color, self, [y1, x])
            when 2 
                self[[y1, x]] = Bishop.new(color, self, [y1, x])
            when 3 
                self[[y1, x]] = King.new(color, self, [y1, x])
            when 4
                self[[y1, x]] = Queen.new(color, self, [y1, x])
            when 5
                self[[y1, x]] = Bishop.new(color, self, [y1, x])
            when 6
                self[[y1, x]] = Knight.new(color, self, [y1, x])
            when 7 
                self[[y1, x]] = Rook.new(color, self, [y1, x])
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
        y,x = pos
        (y).between?(0, 7) && x.between?(0, 7)
    end

    def add_piece(piece, pos)
    end

    def checkmate?(color)
        if in_check?(color) 
            defenders = pieces.select { |piece| piece.color == color }
            checkmate = defenders.any?(&:valid_moves)
        end
        checkmate
    end

    def in_check?(color)
        check = false
        target = find_king(color).pos
        enemies = pieces.select do |piece| 
            piece.color != color 
        end

        enemies.each do |enemy|
            if enemy.moves.include?(target)
                check = true
            end
        end
        check
    end 

    def find_king(color)
        kings = pieces.select { |piece| piece.class == King }
        kings.first.color == color ? kings.first : kings.last
    end

    def pieces
        piece_arr = Array.new
        @rows.each do |col|
           list = col.select do |piece|
                piece.class != Nullpiece
            end
            piece_arr += list
        end
        return piece_arr
    end

    def dup
    end

    def move_piece!(cloor, start_pos, end_pos)
        self[start_pos].pos = end_pos
    end

    private 
    @null_piece = Nullpiece.instance


end
