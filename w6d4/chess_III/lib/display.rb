require 'colorize'
require_relative 'cursor'

class Display
    def initialize(board)
        @board = board 
        @cursor = Cursor.new([0,0], board)
    end

    attr_reader :cursor, :board


    def render
        system("clear")
         @board.rows.each_with_index do |row, y|
            row.each_with_index do |col, x|
                if [y, x] == @cursor.cursor_pos
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
    end
end