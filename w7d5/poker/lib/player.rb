


class Player
    attr_reader :bankroll, :hand, :current_bet, :folded

    def self.buy_in(money)
        Player.new(money)
    end

    def initialize(bankroll)
        @bankroll = bankroll
        @current_bet = 0
        @folded = false
    end
        
    


    def fold
        @folded = true
    end

    def unfold 
        @folded = false
    end

    def folded?
        @folded
    end

    def deal_in(hand)
        @hand = hand
    end

    def reset_current_bet
        @current_bet = 0
    end

    def make_bet
        print "(s)ee, (r)aise, or (f)old? > "
        action = gets.chomp.downcase[0]
        case action
        when "r" then :raise
        when "s" then :see
        when "f" then :fold
        else
            puts 'must be (s)ee, (r)aise, or (f)old'
            make_bet
        end
    end

    def get_bet
        print "Current funds available to bet: $#{bankroll} "
        bet = gets.chomp.to_i
        raise "bet is too big" unless bet <= bankroll

        bet
    end

    def bet(total_bet)
        amount = total_bet - @current_bet
        raise "not enough funds" unless amount <= @bankroll
        @current_bet = total_bet
        @bankroll -= amount
        amount
    end

    def add_winnings(amount)
        @bankroll += amount
    end

    def return_cards
        held_cards = @hand.cards
        @hand = nil
        return held_cards
    end
   
    def <=>(other_player)
        winner = hand.against(other_player.hand)
        winner == hand ? self : other_player
    end

    def get_cards_to_trade
        print "Cards to trade? (ex. '1, 4, 5') > "
        card_indices = gets.chomp.split(', ').map(&:to_i)
        raise 'cannot trade more than three cards' unless card_indices.count <= 3
        puts
        card_indices.map { |i| hand.cards[i - 1] }
      end

    def trade_cards(old_cards, new_cards)
        @hand.replace_cards(old_cards, new_cards)
    end

end