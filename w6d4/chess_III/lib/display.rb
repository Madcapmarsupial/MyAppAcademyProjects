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
        count = 1
        coords = [0,0]
        system("clear")
         @board.rows.each_with_index do |row, y|
            row.each_with_index do |col, x|
                square_color = (count.even? ? :light_blue : :white)
                piece_color = col.color.to_sym


                if [y, x] == @cursor.cursor_pos
                    coords = [y, x]
                    if @cursor.selected
                        print "#{col.to_s} ".colorize(:color => :red, :background => :black)
                    else
                        print "#{col.to_s} ".colorize(:color => :black, :background => :red)
                    end
                else
                    print "#{col.to_s} ".colorize(:color => :black, :background => square_color)
                end
                count += 1
            end
            
            count = (y.even? ? 0 : 1)
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


    # BOARD_MAP = [
    #     [0,0], [0,1], [0,2]. [0,3], [0,4], [0,5], [0,6], [0,7]
    #     [1,0], [1,1], [1,2]. [1,3], [1,4], [1,5], [1,6], [1,7]
    #     [2,0], [2,1], [2,2], [2,3], [2,4], [2,5], [2,6], [2,7]
    #     [3,0], [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7]
    #     [4,0], [4,1], [4,2], [4,3], [4,4], [4,5], [4,6], [4,7]
    #     [5,0], [5,1], [5,2], [5,3], [5,4], [5,5], [5,6], [5,7]
    #     [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]
    #     [7,0], [7,1], [7,2], [7,3], [7,4], [7,5], [7,6], [7,7]
    # ]

end