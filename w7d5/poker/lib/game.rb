require_relative 'deck.rb'
require_relative 'player.rb'

class Game
    attr_reader :deck, :pot, :players
    def initialize
        @deck = Deck.new
        @deck.shuffle
        @pot = 0
        @players = []
        
    end

    def new_game
        @deck = Deck.new
        @deck.shuffle
    end

    def add_to_pot(amount)
        @pot += amount
        amount
    end
    
    def add_players(player_count, bankroll)
        player_count.times { |i| @players << Player.new(bankroll) }
    end

    def deal
        @players.each do |player| 
            hand = deck.deal_hand
            if player.bankroll > 0
                player.deal_in(hand) 
            end
        end
    end

    def current_player
        @players.first
    end    

    def next_turn
        first = @players.shift
        @players << first
    end

    def game_over?
        return players.one? { |player| player.bankroll > 0 }
    end

    def bet_phase(stake)
        players.count.times do |i|
            begin
                p 
                p current_player.bankroll
                p current_player.hand.to_s
                action = current_player.make_bet
              
                case action 
                when :fold
                    current_player.fold
                    players.shift
                when :see
                    current_player.bet(stake)
                    add_to_pot(stake)
                    next_turn
                when :raise
                    p "enter the new total stake"
                    total = current_player.get_bet
                    raise "amount must be larger then the stake #{stake}" unless total > stake
                    stake += current_player.bet(total)
                    add_to_pot(stake)
                    next_turn
                end
            rescue
                p "try again"
                 retry   
            end
        end
        stake
    end

    def draw_phase
        players.count do |i|
            discards = current_player.get_cards_to_trade
            deck.return(discards)
            current_player.trade_cards(discards, deck.take(discards.count))
            next_turn
        end
    end


    def showdown
        winner = players.inject(current_player) do |acc, player|
            acc = ( acc <=> player )
        end
        winner
    end

    def play(buy_in_amount)
        #deal
        #bet
        deal
        stake = bet_phase(buy_in_amount)
        return get_winner(current_player) if game_over?
        draw_phase
        bet_phase(stake)
        return get_winner(current_player) if game_over?
        get_winner(showdown)
        
    end


    def get_winner(player)
        p "#{player} wins!"
    end

end


if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.add_players(3, 100)
    g.play(10)
end