class Queue
    def initialize
        @list = []
    end
    
    def enqueue(ele)
        @list.push(ele)
    end

    def dequeue
        @list.shift
    end

    def peek
        @list.first
    end
    
    def size
        @list.size
    end

    def empty?
        @list.empty?
    end
end

#O(n^2)
def  naive_windowed_max_range(arr, range)
    current_max = arr[0..1].max - arr[0..1].min
    arr.each_with_index do |ele, i|
        max = arr[i...i+range].max 
        min = arr[i...i+range].min
            current_max = (max - min) if (max - min) > current_max
    end

    return current_max
end

class StackQueue
    def initialize
        @in_stack = Stack.new
        @out_stack = Stack.new
    end

    def enqueue(ele)
        @out_stack.push(ele)
    end

    def dequeue
      if @in_stack.empty?
        until @out_stack.empty?
            @in_stack.push(@out_stack.pop)
        end
        @in_stack.pop
      else
        @in_stack.pop
      end
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end
end

class Stack
    def initialize
        @list = []
    end
    
    def push(ele)
        @list.unshift(ele)
    end

    def pop
        @list.pop
    end

    def peek
        @list.last
    end

    def empty?
        @list.empty?
    end
end

class MinMaxStack
    def initialize
        @list = []
        @max = nil
        @min = nil
    end

    attr_reader :max, :min
    
    def push(ele)
        @max = ele if (@max == nil || @max < ele)
        @min = ele if (@min == nil || @min > ele)

        @list.unshift(ele)
    end

    def pop
        ele = @list.pop

        if @max == ele
            @max = @list.max
        end

        if @min == ele 
            @min = @list.min
        end

        ele
    end

    def peek
        @list.last
    end

     def size
        @list.size
    end

    def empty?
        @list.empty?
    end
end


class MinMaxStackQueue
    def initialize
        @in_stack = MinMaxStack.new
        @out_stack = MinMaxStack.new
    end

    def enqueue(ele)
        @out_stack.push(ele)
    end

    def dequeue
      if @in_stack.empty?
        until @out_stack.empty?
            @in_stack.push(@out_stack.pop)
        end
        @in_stack.pop
      else
        @in_stack.pop
      end
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end

    def max
        maxes = []
        maxes << @out_stack.max unless @out_stack.empty?
        maxes << @in_stack.max unless @in_stack.empty?
        maxes.max
    end

    def min
        mins = []
        mins << @out_stack.min unless @out_stack.empty?
        mins << @in_stack.min unless @in_stack.empty?
        mins.min
    end
end

def  windowed_max_range(arr, range)
#    current_max = arr[0..1].max - arr[0..1].min
    window = MinMaxStackQueue.new
    current_max = nil
    arr.each do |ele|
        if window.size != range    
            window.enqueue(ele)
        else
            window.dequeue
            window.enqueue(ele)

            if current_max == nil || (window.max - window.min) > current_max
                current_max = (window.max - window.min)
            end
        end 
    end

    return current_max
end


p windowed_max_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8`