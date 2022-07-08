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
        [ double("card", :suit => "clubs", :value => "5"),
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
    let(:all_kind_cards) do
        [ double("card", :suit => "clubs", :value => "5"),
          double("card", :suit => "spades", :value => "9"),
          double("card", :suit => "clubs", :value => "7"),
          double("card", :suit => "hearts", :value => "6"),
          double("card", :suit => "diamonds", :value => "King") ]
    end


    # test  hands
    let(:royal_straight_hand) { Hand.new(royal_straight) }
    let(:seq_straight_hand) { Hand.new(seq_straight) }
    let(:seq_hand) { Hand.new(only_seq)}
    let(:mixed_hand) { Hand.new(all_kind_cards)}
   
    
    describe '#royal_flush?' do
        subject(:hand) { Hand.new(seq_straight_royals) }
        it "returns true if the hand is all the same suit" do
            expect(hand.royal_flush?).to eq(true)
        end

        it "returns false if the hand is non-sequential" do
            expect(royal_straight_hand.royal_flush?).to eq(false)
        end

        it "should have all the royals" do
            expect(seq_straight_hand.royal_flush?).to eq(false)
        end
    end
     
    describe '#straight_flush?' do
        it "should be sequential" do
            expect(seq_straight_hand.straight_flush?).to eq(true)
        end
        
        it "should be flush" do 
            expect(seq_hand.straight_flush?).to eq(false)
        end
    end

    describe '#four_kind?' do
        subject(:four_hand) {Hand.new(four_kind_cards)}

        it "should contain all four suits" do 
            expect(royal_straight_hand.four_kind?).to eq(false)
        end

        it " should contain four of the same value" do 
            expect(mixed_hand.four_kind?).to eq(false)
        end


        it "returns true if the hand contains four of a kind and varied suit" do
            expect(four_hand.four_kind?).to eq(true)
        end
 
    end

    describe '#full_house?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end

    describe '#flush?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end


    describe '#straight?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end

    describe '#three_kind?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end

    describe '#two_pair?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end

    describe '#pair?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end

    describe '#high_card?' do
        it "returns true if the hand is present otherwise false" do
        end
 
    end


end