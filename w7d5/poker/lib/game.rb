require_relative 'deck.rb'
require_relative 'player.rb'

class Game
    attr_reader :deck, :pot, :players
    def initialize
        @deck = Deck.new
        @pot = 0
        @players = []
        
    end

    def new_game
        @deck = Deck.new
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


end