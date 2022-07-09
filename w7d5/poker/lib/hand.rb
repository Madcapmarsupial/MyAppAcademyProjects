class Hand

    VALUES = %w[ 2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
    SUITS = %w[ hearts diamonds clubs spades]
    ROYALS = VALUES.slice(9..-1)

    def initialize(cards)
        @cards = cards
    end

    def royal_flush?
        return sequential? && is_flush? && royals?
    end

    def straight_flush?
        return sequential? && is_flush?
    end


    def four_kind?
        @cards.any? do |card|
            value_count(card.value) == 4
        end
    end

    def full_house?
        triplet = false
        pair = false
        @cards.each do |card| 
            if value_count(card.value) == 3
                triplet = true
            elsif value_count(card.value) == 2
                pair = true
            end
        end
        return pair && triplet
    end

    def flush?
        is_flush? && !sequential?
    end
    
    def straight?
        sequential?
    end

    def three_kind?
        triplet = @cards.any? do |card|
            value_count(card.value) == 3
        end

        if triplet
            kicker = @cards.any? do |card|
                value_count(card.value) == 1
            end
        end

        triplet && kicker
    end

    def two_kind?
        pair_one = nil
        pair_two = nil

        @cards.each do |card|
            if value_count(card.value) == 2 && pair_one == nil
                pair_one = card.value
            elsif value_count(card.value) == 2 && card.value != pair_one
                pair_two = card.value
            end
        end
        pair_one != nil && pair_two != nil
    end

    def pair?
        kickers = @cards.inject(0) do |count, card| 
            count += 1 if value_count(card.value) == 1
            count
        end
        #if there are three kickers the remaining two cards in the hand must be a pair
        kickers == 3
    end

    def high_card?
        return false if is_flush? || sequential?

        kickers = @cards.inject(0) do |count, card| 
            count += 1 if value_count(card.value) == 1
            count
        end
        kickers == 5
    end






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

    
    def is_flush?
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

    def value_count(target)
        raise "bad search criteria --> #{target}" if !VALUES.include?(target)

        @cards.inject(0) do |acc, card| 
            if card.value == target
                acc += 1 
            else
                acc
            end
        end
    end

    def suit_count(target)
        raise "bad search criteria" if !SUITS.include?(target)

        @cards.inject(0) do |acc, card| 
            if card.suit == target
                acc += 1 
            else
                acc
            end
        end
    end


end