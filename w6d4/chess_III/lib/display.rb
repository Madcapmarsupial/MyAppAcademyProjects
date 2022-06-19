require 'colorize'
require_relative 'cursor'

class Display
    def initialize(board, flag)
        @debug = flag
        @board = board 
        @cursor = Cursor.new([0,0], board)
    end

    attr_reader :cursor, :board


    def render

        coords = [0,0]
        system("clear")
         @board.rows.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if [y, x] == @cursor.cursor_pos
                    coords = [y, x]
                    if @cursor.selected
                        print col.to_s.colorize(:color => :white, :background => :blue)
                    else
                        print col.to_s.colorize(:color => :blue, :background => :white)
                    end
                else
                    print col.to_s
                end
            end
            print "\n"
        end

        if @debug
            p "coords => #{coords}"
            if @board[coords].class != Nullpiece
            p @board[coords].valid_moves 
            p @board.in_check?(@board[coords].color)
            p @board[coords].color
            end
        end
    end
end