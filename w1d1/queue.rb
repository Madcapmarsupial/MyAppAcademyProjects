class Queue
    def initialize
        @queue = []
    end

    def enqueue(ele)
        @queue << ele
    end

    def dequeue
        @queue.shift
    end

    def peek 
        @queue
    end
end