

class Card
    attr_reader :suit, :value
    def initialize(value, suit)
        @value = value 
        @suit = suit
    end

    def to_s
        "#{value} of #{suit}"
    end
end