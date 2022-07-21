require 'rspec'
require 'card'

describe Card do 
    let(:deck) {double('deck')}
    subject(:card) { Card.new("5", "hearts") }
    
    describe '#value' do
        it "fetches the card value" do
            expect(card.value).to eq("5")
        end
    end

    describe '#suit' do 
        it 'fetches the card suit' do 
            expect(card.suit).to eq("hearts")
        end 
    end

    describe '#to_s' do 
        it 'returns the the string of suit and value' do
            expect(card.to_s).to include("5hearts")
        end
    end
end