require 'rspec'
require 'game'

describe Game do 
    subject(:game) { Game.new }
    let (:deck) { double ("deck" ) }
    
    describe '#new_deck' do
        it "assigns a new (full) deck" do
            allow(deck).to receive(:count).and_return(52)
            game.new_game
            expect(game.deck.count).to eq(52)
        end
    end

    describe "#players" do
        it "should return an array of players" do 
            expect(game.players).to eq([])
            game.add_players(2, 1000)
            expect(game.players.count).to eq(2)
        end
    end

    describe "#add_players" do 
        it "should create the specified number of players" do 
            game.add_players(3, 1000)
            expect(game.players.count).to eq(3)
        end

        it "should create players" do 
            game.add_players(3, 1000)
            game.players.each do |player|
                expect(player).to be_a(Player)
            end

        end 

        it "should set the players bankroll" do
            game.add_players(3, 1000)
            game.players.each do |player|
                expect(player.bankroll).to eq(1000)
            end
        end
    end

    describe "#add_to_pot" do 
        it "should add amount to the pot" do 
            expect do 
                game.add_to_pot(10)
            end.to change { game.pot }.by(10)
        end

        it "should return the amount added" do 
            expect(game.add_to_pot(10)).to eq(10)
        end  
    end

    describe "#deal" do

        it "should give each player a full hand" do 
            game.add_players(3, 1000)
            game.deal
            game.players.each do |player|
                expect(player.hand.count).to eq(5)
            end
        end

        it "should not give a player a hand if the player has no money" do 
            game.add_players(1, 0)
            game.deal
            game.players.each do |player|
                expect(player.hand).to eq(nil)
            end
        end
    end


    describe "#game_over?" do 
        it "should return false when players still have money" do 
            game.add_players(2, 10)
            game.deal
            expect(game.game_over?).to eq(false)
        end
        it "should return true when all but one player has no more money" do 
            game.add_players(1, 10)
            game.add_players(2, 0)
            game.deal
            expect(game.game_over?).to eq(true)
        end
    end
end