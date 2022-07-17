
require_relative './poker_hands'

class Hand
  include PokerHands

    attr_reader :cards

    def initialize(cards)
        raise "must have five cards" unless cards.count == 5
        @cards = cards
    end

    def include?(card)
        @cards.include?(card)
    end

    def card_sort!
      @cards.sort! { |card_a, card_b|  self.card_rank(card_a) <=> self.card_rank(card_b)} 
      @cards
    end

    def replace_cards(discards, draws)
      raise "you don't hold that card" unless discards.all? { |discard| self.include?(discard) }
      raise "you already hold that card" unless draws.all? { |draw| !self.include?(draw) }

      @cards -= discards
      @cards += draws
    end

    def count
      @cards.count
    end

end