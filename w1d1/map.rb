class Map
    def initialize
        @map = []
    end

    def set(key, value)
        if self.get(key) == nil
            new_pair = [key, value]
            @map << new_pair
        else
            @map.each { |pair| pair[1] = value if (pair.first == key)}
        end
    end

    def get(key)
        @map.each {|pair| return pair.last if (pair.first == key) }
        nil
    end

    def delete(key)
        @map.each {|pair| @map.delete(pair) if (pair.first == key) }
    end

    def show
        @map
    end
end