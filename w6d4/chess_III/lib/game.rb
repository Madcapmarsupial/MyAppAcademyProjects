require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game
    def initialize(debug=false)
        @game_board = Board.new
        @display = Display.new(@game_board, debug)
        @player_1 = Human.new(:white, @display)
        @player_2 = Human.new(:black, @display)
        @current_player = @player_1
    end


    def play
        until @game_board.checkmate?(@current_player.color.to_s)
            notify_players
            @current_player.make_move(@game_board)
            swap_turn!
        end
    end



    private 
    def notify_players
        p "#{@current_player.color} -- YOUR TURN"
    end

    def swap_turn!
        @current_player.color == :white ? @current_player = @player_2 : @current_player = @player_1
     end
end










g = Game.new(false)
g.play



# def loop
#     b = Board.new 
#     d = Display.new(b, true)
#     while true
#       # p d.cursor.cursor_pos
#        start, end_pos = nil, nil
#         until start != nil
#         d.render
#             start = d.cursor.get_input
#         end

#         until end_pos != nil
#         d.render
#             end_pos = d.cursor.get_input
#         end

#         b.move_piece(b[start].color, start, end_pos )
#     end   
# end

# loop




# b.move_piece("white", [1,2], [2,2])
# b.move_piece("black", [6,3], [4,3])
# b.move_piece("white", [1,1], [3,1])
# b.move_piece("black", [7,4], [3,0])
