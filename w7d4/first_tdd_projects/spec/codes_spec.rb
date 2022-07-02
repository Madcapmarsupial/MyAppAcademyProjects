require 'rspec'
require 'codes'


#is the returned array new?
#is there any duplicates
describe Array do 


    describe "#my_uniq" do 
        subject(:list) { Array.new([1, 2, 2, [3, 1, 2, 3], 1 ,3, 2, 5]) }

        it "It returns the unique elements in the order in which they first appeared" do
            expect(list.my_uniq).to eq([1, 2, [3,1,2,3], 3, 5])
        end

        it "it should take in an Array and return a new array." do 
            expect(list.my_uniq).to_not be(list)
        end

    end


    describe "#two_sum" do 
        subject(:numbers) {[-1, 0, 2, -2, 1]}
        it "finds all pairs of positions where the elements at those positions sum to zero." do 

            expect(numbers.two_sum).to eq([[0, 4], [2, 3]])
        end

        

        it "the array of pairs should be sorted 'dictionary-wise" do 
            numbers = [1, -1, -1]
           expect(numbers.two_sum).to eq([[0, 1], [0, 2]])
        end 
    end


    describe "#my_transpose" do 
        subject(:grid) {[
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]}
        it "will convert between the row-oriented and column-oriented representations." do
            expect(grid.my_transpose).to eq([[0, 3, 6],[1, 4, 7],[2, 5, 8]])
        end
    end


    describe "stock_picker" do 
        subject(:prices) {[10, 15, 8, 7, 6, 11, 14, 5]}
        
        it "outputs the most profitable pair of days on which to first buy the stock, then sell the stock" do
            expect(prices.stock_picker).to eq([4, 6])
        end
    end
end


describe Towers do 
    subject(:game) { Towers.new}

    describe '#move' do 
        it 'takes the upper disk from one of the stacks and places it on top of another stack or on an empty rod.' do
            game.move([0, 1])
            expect(game.towers[1]).to eq([1])
            expect(game.towers[0]).to eq([3, 2])
        end

        it 'raises an error if the first rod selected is empty' do 
            
            expect { game.move([2, 0]) }.to raise_error(ArgumentError)
        end

        it 'raises an error if the a larger disk is placed on a smaller disk' do 
            game.move([0,1])
            expect { game.move([0, 1]) }.to raise_error(ArgumentError)
        end
    end

    describe '#won?' do 
        before(:each) do 
            game.towers[0] = []
            game.towers[1] = []
            game.towers[2] = [3, 2, 1]
        end

        it 'checks to see if all discs are on the final pole' do
            expect(game.towers[0]).to eq([])
            expect(game.towers[1]).to eq([])
            expect(game.won?).to eq(true)
        end
    end

end


# Only one disk may be moved at a time.
# Each move consists of 
# No disk may be placed on top of a disk that is smaller than it.