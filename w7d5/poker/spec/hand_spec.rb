require 'rspec'
require 'hand'

describe Hand do 
    #test cards
  
    let(:royal_flush_cards) do
        [ double("card", :suit => "♠", :value => "A"),
          double("card", :suit => "♠", :value => "K"),
          double("card", :suit => "♠", :value => "Q"),
          double("card", :suit => "♠", :value => "J"),
          double("card", :suit => "♠", :value => "10") ]
    end
    let(:straight_flush_cards) do
        [ double("card", :suit => "♠", :value => "K"),
          double("card", :suit => "♠", :value => "Q"),
          double("card", :suit => "♠", :value => "J"),
          double("card", :suit => "♠", :value => "10"),
          double("card", :suit => "♠", :value => "9") ]
    end
    let(:high_straight_cards) do
        [ double("card", :suit => "♠", :value => "A"), 
          double("card", :suit => "♣", :value => "K"),
          double("card", :suit => "♠", :value => "Q"),
          double("card", :suit => "♠", :value => "J"),
          double("card", :suit => "♠", :value => "10") ]
    end
    let(:straight_cards) do
        [ double("card", :suit => "♣", :value => "K"),
          double("card", :suit => "♠", :value => "Q"),
          double("card", :suit => "♠", :value => "J"),
          double("card", :suit => "♠", :value => "10"),
          double("card", :suit => "♠", :value => "9") ]
    end
    let(:low_straight_cards) do
        [ double("card", :suit => "♣", :value => "Q"),
          double("card", :suit => "♠", :value => "J"),
          double("card", :suit => "♥", :value => "10"),
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♠", :value => "8") ]
    end
    let(:kicker) { double("card", :suit => "♣", :value => "5") }
    let(:four_of_a_kind_cards) do
        [ kicker,
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♣", :value => "9"),
          double("card", :suit => "♥", :value => "9"),
          double("card", :suit => "♦", :value => "9") ]
    end
    let(:three_of_a_kind_cards) do
        [ double("card", :suit => "♣", :value => "5"),
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♣", :value => "7"),
          double("card", :suit => "♥", :value => "7"),
          double("card", :suit => "♦", :value => "7") ]
    end
    let(:full_cards) do
        [ double("card", :suit => "♣", :value => "5"),
          double("card", :suit => "♠", :value => "5"),
          double("card", :suit => "♥", :value => "5"),
          double("card", :suit => "♥", :value => "K"),
          double("card", :suit => "♦", :value => "K") ]
    end
    let(:flush_cards) do
        [ double("card", :suit => "♠", :value => "K"),
          double("card", :suit => "♠", :value => "3"),
          double("card", :suit => "♠", :value => "5"),
          double("card", :suit => "♠", :value => "10"),
          double("card", :suit => "♠", :value => "9") ]
    end
    let(:two_pair_kind_cards) do
        [ double("card", :suit => "♣", :value => "5"),
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♣", :value => "9"),
          double("card", :suit => "♥", :value => "8"),
          double("card", :suit => "♦", :value => "8") ]
    end
    let(:pair_cards) do
        [ double("card", :suit => "♣", :value => "5"),
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♣", :value => "7"),
          double("card", :suit => "♥", :value => "10"),
          double("card", :suit => "♦", :value => "10") ]
    end
    let(:mixed_kind_cards) do
        [ double("card", :suit => "♣", :value => "5"),
          double("card", :suit => "♠", :value => "9"),
          double("card", :suit => "♣", :value => "7"),
          double("card", :suit => "♥", :value => "10"),
          double("card", :suit => "♦", :value => "2") ]
    end

    # test  hands
    let(:royal_flush_hand) { Hand.new(royal_flush_cards) }
    let(:straight_flush_hand) { Hand.new(straight_flush_cards) }
    let(:high_straight_hand) { Hand.new(high_straight_cards)}
    let(:straight_hand) { Hand.new(straight_cards)}
    let(:low_straight_hand) { Hand.new(low_straight_cards)}
    let(:three_hand) { Hand.new(three_of_a_kind_cards)}
    let(:flush_hand) {Hand.new(flush_cards)}
    let(:full_hand) { Hand.new(full_cards) }
    let(:four_hand) {Hand.new(four_of_a_kind_cards)}
    let(:two_hand) {Hand.new(two_pair_kind_cards)}
    let(:mixed_hand) { Hand.new(mixed_kind_cards)}
    let(:pair_hand) { Hand.new(pair_cards) }


    #joker and five of a kind not implemented
    #poker_hand tests

    describe '#straight_flush?' do
        it "should be sequential" do
            expect(flush_hand.straight_flush?).to eq(false)
        end
        
        it "should be flush" do 
            expect(straight_hand.straight_flush?).to eq(false)
        end
    end

    describe '#four_of_a_kind?' do

        it "should contain all four suits" do 
            expect(royal_flush_hand.four_of_a_kind?).to eq(false)
        end

        it " should contain four of the same value" do 
            expect(three_hand.four_of_a_kind?).to eq(false)
            expect(straight_hand.four_of_a_kind?).to eq(false)
            expect(low_straight_hand.four_of_a_kind?).to eq(false)
            expect(high_straight_hand.four_of_a_kind?).to eq(false)
        end
    end

    describe '#full_house?' do
        it "holds three of one kind and two of another" do
            expect(royal_flush_hand.full_house?).to eq(false)
            expect(three_hand.full_house?).to eq(false)
        end
    end

    describe '#flush?' do
        it "contains five cards all of the same suit" do
            expect(mixed_hand.flush?).to eq(false)
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
            expect(straight_flush_hand.straight?).to eq(false)
        end

        it "contains no duplicate values" do 
            expect(three_hand.straight?).to eq(false)
            expect(four_hand.straight?).to eq(false)
            expect(mixed_hand.straight?).to eq(false)
        end
    end

    describe '#three_of_kind?' do
        it "contains three cards of one rank and two cards of two other ranks" do
            expect(mixed_hand.three_of_a_kind?).to eq(false)
            expect(full_hand.three_of_a_kind?).to eq(false)
            expect(four_hand.three_of_a_kind?).to eq(false)
            expect(straight_hand.three_of_a_kind?).to eq(false)
            expect(straight_flush_hand.three_of_a_kind?).to eq(false)


        end
    end

    describe '#two_pair?' do
        it "contains two distinct pairs of cards of one rank, and one card of a third rank" do
            expect(four_hand.two_pair?).to eq(false)
            expect(three_hand.two_pair?).to eq(false)
            expect(mixed_hand.two_pair?).to eq(false)
        end
    end

    describe '#pair?' do
        it "contains two cards of one rank and three kickers" do
            expect(two_hand.pair?).to eq(false)
            expect(full_hand.pair?).to eq(false)
            expect(mixed_hand.pair?).to eq(false)
            expect(straight_flush_hand.pair?).to eq(false)
            expect(flush_hand.pair?).to eq(false)

        end
    end

    
    describe '#high_card?' do
        it "contains no pairs, just five kickers" do
            expect(straight_flush_hand.high_card?).to eq(false)
            expect(flush_hand.high_card?).to eq(false)
            expect(straight_hand.high_card?).to eq(false)
        end
    end

    #hand vs hand tests

    describe "#rank" do 
        it "returns the current hand type" do
            expect(straight_flush_hand.rank).to eq(:straight_flush)
            expect(four_hand.rank).to eq(:four_of_a_kind)
            expect(full_hand.rank).to eq(:full_house)
            expect(flush_hand.rank).to eq(:flush)
            expect(high_straight_hand.rank).to eq(:straight)
            expect(low_straight_hand.rank).to eq(:straight)
            expect(straight_hand.rank).to eq(:straight)
            expect(three_hand.rank).to eq(:three_of_a_kind)
            expect(two_hand.rank).to eq(:two_pair)
            expect(pair_hand.rank).to eq(:pair)
            expect(mixed_hand.rank).to eq(:high_card)

        end
    end

     describe "#against" do 
         subject(:straight_hand) {Hand.new(straight_cards)}
         let(:losers) {[three_hand, two_hand, pair_hand, mixed_hand]}

        it "returns self hand against lower hands" do 
            losers.each do |loser|
                expect(straight_hand.against(loser)).to eq(straight_hand)
            end
        end

        it "compares hands that share types by card value" do 
            expect(straight_hand.against(low_straight_hand)).to eq(straight_hand)
        end
        
        let(:winners) { [straight_flush_hand, royal_flush_hand, four_hand, flush_hand, full_hand] }

        it "returns the the passed in hand against higher hands" do 
            winners.each do |winner|
                expect(straight_hand.against(winner)).to eq(winner)
            end
        end

        it "compares hands that share types by card value" do 
            expect(straight_hand.against(high_straight_hand)).to eq(high_straight_hand)
        end
        
     end

     describe "#rank_cards" do 
        
        let(:losing_set) do
            [ double("card", :suit => "♠", :value => "J"),
              double("card", :suit => "♠", :value => "8"),
              double("card", :suit => "♠", :value => "6"),
              double("card", :suit => "♠", :value => "4"),
              double("card", :suit => "♠", :value => "2") ]
        end
        let(:winning_set) do
            [
              double("card", :suit => "♥", :value => "8"),
              double("card", :suit => "♥", :value => "6"),
              double("card", :suit => "♥", :value => "4"),
               double("card", :suit => "♥", :value => "J"),
              double("card", :suit => "♥", :value => "3") ]
        end
        
        let(:winner) { Hand.new(winning_set)}
        let(:loser) { Hand.new(losing_set) }
        subject(:straight_hand) {Hand.new(straight_cards)}


        it "settles ties between hand types" do 
            expect(loser.rank_cards(winner)).to eq(winner)
            expect(winner.rank_cards(loser)).to eq(winner)
        end
     end

    #hand utility method tests

    describe "#include?" do
        it "checks to see if the card is pressent in the hand" do
            expect(royal_flush_hand.include?(kicker)).to eq(false)
            expect(four_hand.include?(kicker)).to eq(true)
        end
    end

    describe "#replace_cards" do
        let(:left_over) do 
            [ double("card", :suit => "♠", :value => "9"),
                double("card", :suit => "♣", :value => "7") ]
        end

        let(:old_cards) do 
            [ double("card", :suit => "♣", :value => "5"),
                double("card", :suit => "♥", :value => "10"),
                double("card", :suit => "♦", :value => "2") ]
        end

        subject(:hand) { Hand.new(left_over + old_cards) }

        # [ double("card", :suit => "♣", :value => "5"),
        #     double("card", :suit => "♠", :value => "9"),
        #     double("card", :suit => "♣", :value => "7"),
        #     double("card", :suit => "♥", :value => "10"),
        #     double("card", :suit => "♦", :value => "2") ]

        
        let(:new_cards) do 
            [ double("card", :suit => "♥", :value => "5"),
                double("card", :suit => "♦", :value => "10"),
                double("card", :suit => "♦", :value => "3") ]
        end

        # before(:each) do 
        #     hand.replace_cards(old_cards, new_cards)
        # end


        it "discards old cards" do
            hand.replace_cards(old_cards, new_cards)
            old_cards.each do |old_card|
                expect(hand.include?(old_card)).to eq(false)
            end
        end

        it "draws new cards" do
            hand.replace_cards(old_cards, new_cards)
            new_cards.each do |new_card|
                expect(hand.cards.include?(new_card)).to eq(true)
            end
        end

        let(:card) {  [double("card", :suit => "♦", :value => "J")] }
        let(:unknown) { [double("card", :suit => "♦", :value => "K")] }

        it "raises an error if an unowned card is discarded" do
            expect { hand.replace_cards(unknown, card) }.to raise_error("you don't hold that card")
        end

        it "raises an error if a copy is drawn" do 
            expect { hand.replace_cards([old_cards.last], [old_cards.first]) }.to raise_error("you already hold that card")
        end
    end

    # describe "#card_sort!" do
    #     let(:unsorted_set) do
    #         [
    #           double("card", :suit => "♥", :value => "8"),
    #           double("card", :suit => "♥", :value => "6"),
    #           double("card", :suit => "♥", :value => "4"),
    #            double("card", :suit => "♥", :value => "J"),
    #           double("card", :suit => "♥", :value => "3") ]
    #     end

    #     subject(:hand) {Hand.new(unsorted_set)}
       
    #     let(:sorted_set) do
    #         [double("card", :suit => "♥", :value => "J"),
    #           double("card", :suit => "♥", :value => "8"),
    #           double("card", :suit => "♥", :value => "6"),
    #           double("card", :suit => "♥", :value => "4"),
    #           double("card", :suit => "♥", :value => "3") ]
    #     end
    #     it "should sort cards by highest rank" do 
    #         expect(hand.card_sort!).to eq(sorted_set)
    #     end

    # end




end