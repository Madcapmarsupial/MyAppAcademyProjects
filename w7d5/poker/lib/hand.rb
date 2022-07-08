class Hand

    VALUES = %w[ 2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
    SUITS = %w[ hearts diamonds clubs spades]
    ROYALS = VALUES.slice(9..-1)

    def initialize(cards)
        @cards = cards
    end

    def royal_flush?
        return sequential? && flush? && royals?
    end

    def straight_flush?
        return sequential? && flush?
    end


    def four_kind?
        @cards.each do |card|

        end
    end

    
    # it "should contain one single unique card" do 
    #     expect(four_hand.count(kicker)).to eql(1)
    # end


    private
    
    def card_rank(card)
        case card.value 
        when "Jack"
            return 11
        when "Queen"
            return 12
        when "King"
            return 13
        when "Ace"
            return 14
        else 
            return card.value.to_i
        end
    end

    
    def flush?
        @cards.all? { |card| card.suit == @cards.first.suit }
    end

    def sequential?
        hand = @cards.dup
        until hand.one?
            draw_card = hand.shift
            diff = card_rank(draw_card) - card_rank(hand.first)
            return false if diff != 1
        end
        true
    end

    def royals?
        ROYALS.all? { |royal| hand_values.include?(royal) }
    end

    def hand_suits
        @cards.map(&:suit)
    end

    def hand_values
        @cards.map(&:value)
    end

    def count(target)
        raise "bad search criteria" if !SUITS.include?(target) && !VALUES.include?(target)

        if SUITS.include?(target)
            search = Proc.new { |card| card.suit }
        else 
            search = Proc.new { |card| card.value }
        end

        @cards.inject(0) do |acc, card| 
            if search.call(card) == target
                acc += 1 
            else
                acc
            end
        end
    end

   

end