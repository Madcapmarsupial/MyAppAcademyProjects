require_relative 'card.rb'
require_relative 'hand.rb'

class Deck
    def self.all_cards
        cards = []
        Hand::SUITS.each do |suit|
            Hand::VALUES.each do |value|
                cards << Card.new(value, suit)
            end
        end
        cards
    end


    def initialize(cards = Deck.all_cards)
       @cards = cards
    end

    def take(n)
        raise 'not enough cards' if n > count
        @cards.shift(n)
    end

    def count
        @cards.count
    end

    def return(some_cards)
        @cards += some_cards
    end

    def shuffle
        @cards.shuffle!
    end

    def deal_hand
        cards = take(5)
        Hand.new(cards)
    end

end



