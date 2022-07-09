require 'rspec'
require 'hand'

describe Hand do 
    #test cards
    let(:seq_straight_royals) do
        [ double("card", :suit => "spades", :value => "Ace"),
          double("card", :suit => "spades", :value => "King"),
          double("card", :suit => "spades", :value => "Queen"),
          double("card", :suit => "spades", :value => "Jack"),
          double("card", :suit => "spades", :value => "10") ]
    end
    let(:royal_straight) do
        [ double("card", :suit => "spades", :value => "Ace"),
          double("card", :suit => "spades", :value => "King"),
          double("card", :suit => "spades", :value => "Queen"),
          double("card", :suit => "spades", :value => "Jack"),
          double("card", :suit => "spades", :value => "8") ]
    end
    let(:seq_straight) do
        [ double("card", :suit => "spades", :value => "King"),
          double("card", :suit => "spades", :value => "Queen"),
          double("card", :suit => "spades", :value => "Jack"),
          double("card", :suit => "spades", :value => "10"),
          double("card", :suit => "spades", :value => "9") ]
    end
    let(:only_seq) do
        [ double("card", :suit => "clubs", :value => "King"),
          double("card", :suit => "spades", :value => "Queen"),
          double("card", :suit => "spades", :value => "Jack"),
          double("card", :suit => "spades", :value => "10"),
          double("card", :suit => "spades", :value => "9") ]
    end
    let(:kicker) { double("card", :suit => "clubs", :value => "5") }
    let(:four_kind_cards) do
        [ kicker,
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "9"),
          double("card", :suit => "hearts", :value => "9"),
          double("card", :suit => "diamonds", :value => "9") ]
    end
    let(:three_kind_cards) do
        [ double("card", :suit => "clubs", :value => "5"),
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "7"),
          double("card", :suit => "hearts", :value => "7"),
          double("card", :suit => "diamonds", :value => "7") ]
    end
    let(:full_cards) do
        [ double("card", :suit => "clubs", :value => "5"),
          double("card", :suit => "spades", :value => "5"),
          double("card", :suit => "hearts", :value => "5"),
          double("card", :suit => "hearts", :value => "King"),
          double("card", :suit => "diamonds", :value => "King") ]
    end
    let(:non_seq_straight) do
        [ double("card", :suit => "spades", :value => "King"),
          double("card", :suit => "spades", :value => "3"),
          double("card", :suit => "spades", :value => "5"),
          double("card", :suit => "spades", :value => "10"),
          double("card", :suit => "spades", :value => "9") ]
    end
    let(:two_pair_kind_cards) do
        [ kicker,
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "9"),
          double("card", :suit => "hearts", :value => "8"),
          double("card", :suit => "diamonds", :value => "8") ]
    end
    let(:pair_cards) do
        [ double("card", :suit => "clubs", :value => "5"),
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "7"),
          double("card", :suit => "hearts", :value => "10"),
          double("card", :suit => "diamonds", :value => "10") ]
    end
    let(:mixed_kind_cards) do
        [ double("card", :suit => "clubs", :value => "5"),
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "7"),
          double("card", :suit => "hearts", :value => "10"),
          double("card", :suit => "diamonds", :value => "2") ]
    end

    # test  hands
    let(:royal_straight_hand) { Hand.new(royal_straight) }
    let(:straight_flush_hand) { Hand.new(seq_straight) }
    let(:straight_hand) { Hand.new(only_seq)}
    let(:three_hand) { Hand.new(three_kind_cards)}
    let(:flush_hand) {Hand.new(non_seq_straight)}
    let(:full_hand) { Hand.new(full_cards) }
    let(:four_hand) {Hand.new(four_kind_cards)}
    let(:two_hand) {Hand.new(two_pair_kind_cards)}
    let(:mixed_hand) { Hand.new(mixed_kind_cards)}
    let(:pair_hand) { Hand.new(pair_cards) }


   
    
    describe '#royal_flush?' do
        subject(:hand) { Hand.new(seq_straight_royals) }
        it "returns true if the hand is all the same suit" do
            expect(hand.royal_flush?).to eq(true)
        end

        it "returns false if the hand is non-sequential" do
            expect(royal_straight_hand.royal_flush?).to eq(false)
        end

        it "should have all the royals" do
            expect(straight_flush_hand.royal_flush?).to eq(false)
        end
    end
     
    describe '#straight_flush?' do
        it "should be sequential" do
            expect(straight_flush_hand.straight_flush?).to eq(true)
        end
        
        it "should be flush" do 
            expect(straight_hand.straight_flush?).to eq(false)
        end
    end

    describe '#four_kind?' do

        it "should contain all four suits" do 
            expect(royal_straight_hand.four_kind?).to eq(false)
        end

        it " should contain four of the same value" do 
            expect(three_hand.four_kind?).to eq(false)
        end

        it "returns true if the hand contains four of a kind and varied suit" do
            expect(four_hand.four_kind?).to eq(true)
        end
    end

    describe '#full_house?' do
        it "holds three of one kind and two of another" do
            expect(royal_straight_hand.full_house?).to eq(false)
            expect(three_hand.full_house?).to eq(false)
            expect(full_hand.full_house?).to eq(true)
        end
    end

    describe '#flush?' do
        it "contains five cards all of the same suit" do
            expect(flush_hand.flush?).to eq(true)
        end

        it "not all cards are of sequential rank" do 
            expect(straight_flush_hand.flush?).to eq(false)
        end 
    end

    describe '#straight?' do
        it "contains five cards of sequential rank" do
            expect(flush_hand.straight?).to eq(false)
        end

        it "it contains cards not all of the same suit" do
            expect(straight_hand.straight?).to eq(true)
        end
    end

    describe '#three_kind?' do
        it "contains three cards of one rank and two cards of two other ranks" do
            expect(three_hand.three_kind?).to eq(true)
            expect(full_hand.three_kind?).to eq(false)
            expect(four_hand.three_kind?).to eq(false)
        end
    end

    describe '#two_pair?' do
        it "contains two distinct pairs of cards of one rank, and one card of a third rank" do
            expect(four_hand.two_kind?).to eq(false)
            expect(three_hand.two_kind?).to eq(false)
            expect(two_hand.two_kind?).to eq(true)
        end
    end

    describe '#pair?' do
        it "contains two cards of one rank and three kickers" do
            expect(two_hand.pair?).to eq(false)
            expect(full_hand.pair?).to eq(false)
            expect(mixed_hand.pair?).to eq(false)
            expect(straight_flush_hand.pair?).to eq(false)
            expect(flush_hand.pair?).to eq(false)

            expect(pair_hand.pair?).to eq(true)
        end
    end

    
    describe '#high_card?' do
        it "contains no pairs, just five kickers" do
            expect(straight_flush_hand.high_card?).to eq(false)
            expect(flush_hand.high_card?).to eq(false)
            expect(straight_hand.high_card?).to eq(false)
            expect(mixed_hand.high_card?).to eq(true)
        end
    end

end