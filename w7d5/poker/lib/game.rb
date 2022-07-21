require_relative 'deck.rb'
require_relative 'player.rb'
require 'colorize'
require 'byebug'


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
        (@pot += amount) && amount
    end
    
    def add_players(player_count, bankroll)
        player_count.times { |i| @players << Player.new(bankroll) }
    end

    def deal
        @players.each { |player| player.deal_in(deck.deal_hand) if player.bankroll > 0 }
    end

    def next_turn
        first = @players.shift
        @players << first
    end

    def game_over?
        return players.one? { |player| player.bankroll > 0 }
    end

    def round_over?
        return players.count { |player| !player.folded? } <= 1
    end

    def reset_players
        players.each(&:unfold)
    end

    def render(index, highest_bet)
        puts
        puts "Pot: $#{@pot}"
        puts "High bet: $#{highest_bet}"
    
        players.each_with_index do |player, i|
          puts "Player #{i + 1} has #{player.bankroll}"
        end
    
        puts
        puts "Current player: #{index + 1}"
        puts "Player #{index + 1} has bet: $#{players[index].current_bet}"
        puts "The bet is at $#{highest_bet}"
        puts "Player #{index + 1}'s hand: #{players[index].hand}"
    end

    def get_bets
        players.each(&:reset_current_bet)
        highest_bet = 0
        no_raises = false
        last_better = nil

        until no_raises 
            no_raises = true
            players.each_with_index do |player, i|
                next if player.folded?
                break if player == last_better || round_over?

                render(i, highest_bet)

                begin
                    action = player.make_bet
                    case action 
                    when :see 
                        add_to_pot(player.bet(highest_bet))
                    when :raise 
                        raise "not enough money" unless player.bankroll >= highest_bet
                        no_raises = false
                        last_better = player
                        p "enter the new high bet"
                        total_bet = player.get_bet
                        raise "amount must be larger then $#{highest_bet}" unless total_bet > highest_bet
                        raise_amount = player.bet(total_bet)
                        highest_bet = total_bet
                        add_to_pot(raise_amount)
                    when :fold 
                        player.fold
                    end
                rescue => error
                    p "#{error.message}"
                    retry   
                end

            end
        end
    end

    def draw_phase
        players.each_with_index do |player, i|
            next if player.folded?
            print "Player #{i + 1} which cards would you like to trade: "
            puts player.hand
            discards = player.get_cards_to_trade
            deck.return(discards)
            player.trade_cards(discards, deck.take(discards.count))
            print "New hand"
            puts player.hand
            sleep(3)
        end
    end

    def play_round
        deck.shuffle
        reset_players
        deal
        get_bets
        draw_phase
        get_bets
        round_end
    end

    def show_hands
        players.each_with_index do |player, i|
            puts "Player #{i + 1}'s hand is a #{players[i].hand.rank}: #{players[i].hand}"
        end
    end

    def round_end
        show_hands
        winner = get_winner
        puts
        puts "WINNER"
        puts "#{winner.hand} wins $#{pot} with a #{winner.hand.rank}"
        winner.add_winnings(pot)
        @pot = 0
        players.each(&:return_cards)
    end


    def get_winner
        winner = players.inject(players.first) do |acc, player|
            acc = ( acc <=> player )
        end
        winner
    end
end


if __FILE__ == $PROGRAM_NAME
    g = Game.new
    g.add_players(3, 100)
    g.play_round
end