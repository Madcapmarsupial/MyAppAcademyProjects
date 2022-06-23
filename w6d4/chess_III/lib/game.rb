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
        # is player in check?
        until @game_board.checkmate?(@current_player.color.to_s)
            notify_players
            begin
                @current_player.make_move(@game_board)
            rescue => error
                puts "#{error.message}  -- Try Again"
                sleep(2)
                retry
            end
            swap_turn!
        end

        #switch current player to the one not in check
        swap_turn!
        @display.render
        p "GAME OVER #{@current_player.color} wins!"
    end



    private 
    def notify_players
        p "#{@current_player.color} -- YOUR TURN"
        sleep(1)
    end

    def swap_turn!
        @current_player.color == :white ? @current_player = @player_2 : @current_player = @player_1
     end
end










g = Game.new(false)
g.play

