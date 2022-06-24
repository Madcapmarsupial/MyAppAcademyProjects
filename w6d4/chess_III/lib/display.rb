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
        system("clear")

        highlighted_pos = [0,0]
        row_count = 1
        @board.rows.each_with_index do |row, y|
            row.each_with_index do |col, x|

                if [y, x] == @cursor.cursor_pos
                    highlighted_pos = [y, x]
                    print_selected_square(highlighted_pos)
                else
                    square_color = (row_count.even? ? :light_blue : :white)
                    print_unselected_square([y, x], square_color)
                end
                row_count += 1
            end
            
            row_count = (y.even? ? 0 : 1)
            print "\n"
        end

        debug_display(highlighted_pos) if @debug
    end



    private

    def print_selected_square(pos)
        if @cursor.selected
            print "#{@board[pos].to_s} ".colorize(:color => :red, :background => :black)
        else
            print "#{@board[pos].to_s} ".colorize(:color => :black, :background => :red)
        end
    end

    def print_unselected_square(pos, tile_color)
        print "#{@board[pos].to_s} ".colorize(:color => :black, :background => tile_color)
    end

    def debug_display(pos)
            p "current position => #{pos}"
            if @board[pos].class != Nullpiece
                p "valid moves -->  #{@board[pos].valid_moves}"
                p "#{@board[pos].color} in check? --> #{@board.in_check?(@board[pos].color)}"
                p "piece owner -->  #{@board[pos].color}"
            end
    end
end