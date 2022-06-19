require_relative 'display'
require_relative 'player'
class Human < Player
    def initialize(color, display)
        super
    end

    def make_move(board)
        #@display.cursor.get_input

        start, end_pos = nil, nil
        until start != nil
        @display.render
            start = @display.cursor.get_input
        end

        until end_pos != nil
        @display.render
            end_pos = @display.cursor.get_input
        end

        board.move_piece(color.to_s, start, end_pos)
    end
end