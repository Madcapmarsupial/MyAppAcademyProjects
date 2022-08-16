require 'lru_cache'

describe LRUCache do 
    subject(:cache) { LRUCache.new(4)}

    describe '#count' do 
        before(:each) do 
            cache.add(5)
            cache.add(4)
            cache.add(3)
        end

        it "returns the count of non nil elements" do
            expect(cache.count).to eq(3)
            cache.add(2)
            expect(cache.count).to eq(4)
        end
    end

    describe '#show' do
        before(:each) do 
            cache.add(5)
            cache.add(4)
            cache.add(3)
            cache.add(2)
            cache.add(1)
        end

        it 'print the least used item first' do
            expect(cache.show).to eq([4,3,2,1])
        end
    end


    describe '#add' do 
          before(:each) do 
            cache.add(5)
            cache.add(4)
            cache.add(3)
            cache.add(2)
            cache.add(1)
        end
        it "adds an element to the cache" do
            cache.add("x")
            expect(cache.show).to eq([3,2,1, "x"])
        end

    
        it "maintains lru first ordering" do
            cache.add(5)
            expect(cache.show).to eq([3,2,1,5])            
        end

        it "doesnt add duplicates" do 
            cache.add(5)
            cache.add(5)
            cache.add(5)
            cache.add(5)
            expect(cache.show).to eq([3,2,1,5])            
        end 
    end
end