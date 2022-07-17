module PokerHands

    VALUES = %w[ 2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
    SUITS = %w[ hearts diamonds clubs spades]
    ROYALS = VALUES.slice(9..-1)
    RANKS = { 
        :straight_flush => 900, 
        :four_of_a_kind => 800, 
        :full_house => 700, 
        :flush => 600, 
        :straight => 500, 
        :three_of_a_kind => 400, 
        :two_pair => 300,
        :pair => 200, 
        :high_card => 100
    }

    def royal_flush?
        return sequential? && is_flush? && royals?
    end

    def straight_flush?
        return sequential? && is_flush?
    end

    def four_of_a_kind?
        self.cards.any? do |card|
            value_count(card.value) == 4
        end
    end

    def full_house?
        triplet = false
        pair = false
        self.cards.each do |card| 
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
        sequential? && !is_flush?
    end

    def three_of_a_kind?
        triplet = self.cards.any? do |card|
            value_count(card.value) == 3
        end

        if triplet
            kicker = self.cards.any? do |card|
                value_count(card.value) == 1
            end
        end

        triplet && kicker
    end

    def two_pair?
        pair_one = nil
        pair_two = nil

        self.cards.each do |card|
            if value_count(card.value) == 2 && pair_one == nil
                pair_one = card.value
            elsif value_count(card.value) == 2 && card.value != pair_one
                pair_two = card.value
            end
        end
        pair_one != nil && pair_two != nil
    end

    def pair?
        kickers = self.cards.inject(0) do |count, card| 
            count += 1 if value_count(card.value) == 1
            count
        end
        #if there are three kickers the remaining two cards in the hand must be a pair
        kickers == 3
    end

    def high_card?
        return false if is_flush? || sequential?

        kickers = self.cards.inject(0) do |count, card| 
            count += 1 if value_count(card.value) == 1
            count
        end
        kickers == 5
    end

    def rank
        hands = {
            :high_card => high_card?,
            :pair => pair?,
            :two_pair => two_pair?,
            :three_of_a_kind => three_of_a_kind?,
            :straight => straight?,
            :flush => flush?,
            :full_house => full_house?,
            :four_of_a_kind => four_of_a_kind?,
            :straight_flush => straight_flush? 
        }

        hands.each_pair { |hand_symbol, hand_type| return hand_symbol if hand_type }
    end

    def against(opponent)
        if RANKS[self.rank] == RANKS[opponent.rank]
             return self.rank_cards(opponent)
        end
        
        RANKS[self.rank] > RANKS[opponent.rank] ? self : opponent
    end

    def rank_cards(opponent)
        card_sort!
        opponent.card_sort!
        (0..self.cards.length).each do |i|  
            next if self.card_ranks[i] == opponent.card_ranks[i]
            return self.card_ranks[i] > opponent.card_ranks[i] ? self : opponent
        end

    end

    def card_ranks
        self.cards.map { |card| card_rank(card) }
    end

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

    private

   
    
    def is_flush?
        self.cards.all? { |card| card.suit == self.cards.first.suit }
    end

    def sequential?
        hand = self.cards.dup
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
        self.cards.map(&:suit)
    end

    def hand_values
        self.cards.map(&:value)
    end

    def value_count(target)
        raise "bad search criteria --> #{target}" if !VALUES.include?(target)

        self.cards.inject(0) do |acc, card| 
            if card.value == target
                acc += 1 
            else
                acc
            end
        end
    end

    def suit_count(target)
        raise "bad search criteria" if !SUITS.include?(target)

        self.cards.inject(0) do |acc, card| 
            if card.suit == target
                acc += 1 
            else
                acc
            end
        end
    end

end