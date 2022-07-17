require 'rspec'
require 'player'

describe Player do 
    subject(:player) { Player.new(100) }
    let(:hand) { double ('hand') }

    #let(:hand) double('hand')
    describe "::buy_in" do 
            it "creates a player" do 
                expect(Player.buy_in(100)).to be_a(Player)
            end

            it "sets the bankroll to equal amount passed in" do 
                bob = Player.buy_in(10)
                expect(bob.bankroll).to eq(10)
            end
    end

    describe "#deal_in" do 
        it "assigns a hand to a player" do 
            player.deal_in(hand)
            expect(player.hand).to eq(hand)
        end
    end


    describe "#bet" do 
        it "should subtract amount from the players bankroll" do
            expect do 
                player.bet(20) 
            end.to change { player.bankroll }.by(-20)
        end

        it 'should decrement the players bankroll by the raise amount' do
            player.bet(10)
            expect do
              player.bet(20)
            end.to change { player.bankroll }.by(-10)
          end

        it "returns subtracted amount" do
            expect(player.bet(20)).to eq(20)
        end

        it "should raise an error if a player bets more then their bankroll" do
            expect{player.bet(1000)}.to raise_error("not enough funds")
        end 
    end

    describe "#add_winnings" do
        it "should add winnings to bankrol" do
            expect do
                player.add_winnings(20)
            end.to change {player.bankroll}.by(20)
        end
    end

    describe "#fold" do
        it "should set folded to true" do
            player.fold
            expect(player.folded).to eq(true)
        end
    end 

    describe "#unfold" do
        it "should set folded to false" do
            player.unfold
            expect(player.folded).to eq(false)
        end
    end 

   describe "#folded?"  do
    let(:player) { Player.new(1000) }

    it "should return true if player is folded" do
        player.fold
        expect(player.folded?).to eq(true)
    end

    it "should return false otherwise" do
        expect(player.folded?).to eq(false)
    end
   end 

   describe "return_cards" do 
    let(:hand) { double( "hand" ) }
    let(:cards) { double( "cards" ) }

    before(:each) do 
        player.deal_in(hand)
        allow(hand).to receive(:cards).and_return(cards) 
    end

    it "should return the players cards" do
        expect(player.return_cards).to eq(cards)
    end

    it "should set the players hand to nil" do
        player.return_cards
        expect(player.hand).to eq(nil)
    end
   end
end