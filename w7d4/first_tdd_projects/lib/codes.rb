class Array
    def my_uniq
        arr_dup = Array.new

        self.each do |ele| 
            if !arr_dup.include?(ele) 
                arr_dup << ele
            end
        end
        arr_dup
    end

    def two_sum
        pairs = Array.new
        length = self.length - 1
        (0...length).each do |i|
            (i+1..length).each { |j| pairs << [i, j] if (self[i] + self[j] == 0) }
        end 
        pairs
    end

    def my_transpose
        new_grid = Array.new(self.length) { Array.new}
        length = self.length
        (0...length).each do |y|
            (0...length).each do |x|
                new_grid[x] << self[y][x]
            end
        end
        new_grid
    end

    def stock_picker
        length = self.length - 1 
        sale = 0
        days = []
        (0..length).each do |i|
            (i+1...length).each do |j|
                gain = self[j] - self[i]

                if gain > sale
                    sale = gain
                    days = [i, j]
                end
            end
        end
        days
    end

end




class Towers
    attr_accessor :towers
    def initialize
        @towers = [[3, 2, 1], [], []]
    end

    def move(pos)
       from, to = pos[0], pos[1]

      if towers[from].empty?
        raise ArgumentError
      else 
        disk = towers[from].pop 
      end


       if !towers[to].empty?
            raise ArgumentError unless towers[to].last > disk 
            towers[to] << disk
       else 
            towers[to] << disk 
       end

    end

    def won?
        return true if towers[0].empty? && towers[1].empty?
        false
    end

    def play

        until won?
            begin 
            system("clear")
            p towers
            from = gets.chomp.to_i
            to = gets.chomp.to_i
            move([from, to])
            rescue 
                p "that didn't work try again"
                sleep(2)
                retry 
            end
        end

    end

end

a = Towers.new
a.play