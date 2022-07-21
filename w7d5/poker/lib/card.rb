require 'colorize'

class Card
    attr_reader :suit, :value
    def initialize(value, suit)
        @value = value 
        @suit = suit
    end

    def to_s

        case suit
        when "♥" then color = :red
        when "♦" then color = :red
        else color = :black
        end



        "#{value}#{suit} |".colorize(:color => color, :background => :white)
    end
end