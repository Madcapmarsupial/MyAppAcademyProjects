require_relative 'display'
require_relative 'player'
class Human < Player
    def initialize(color, display)
        super
    end

    def make_move(board)
        start, end_pos = nil, nil

        until start != nil && board[start].color == color.to_s
            @display.render
            start = @display.cursor.get_input
        end

        until end_pos != nil  && board[end_pos].color != color.to_s
            @display.render
            end_pos = @display.cursor.get_input
        end

        board.move_piece(color.to_s, start, end_pos)
    end
end