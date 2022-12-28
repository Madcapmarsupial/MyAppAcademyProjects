





#O(n) linear time complexity 
#O(n) space complexity
def two_sum?(arr, target)
    hash_map = Hash.new
    arr.each do |num|
        #map out hash   difference=>number
        hash_map[target - num] = num
    end

    hash_sum_pairs = 0
    arr.each do |num|
        #if the current num in the array is not a key/difference within the hash
        # then this is not part of a sum pair and we skip it
        next if hash_map[num] == nil 
        #otherwise we know it is a pair
        hash_sum_pairs += 1
        return true if hash_sum_pairs == 2
    end

    return false
end

arr = [1, 3, 2, 7, 5]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false



# we have a target we subtract NUm_A from the target to find the difference
#we place num_A in an arr and remove it from consideration

#we then can call two_sum on the remaining number B 
    #if false 
        #we rule out num_A for good
        #and restart moving to the next ele
    # if true 
        #we have two branch to check C and D only one needs to return true 
    #if both false both can be removed from consideration
    #one must be true and the other must simply be present 


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




class Queue
    def initialize(arr=[])
        @list = arr
    end
    
    def enqueue(ele)
        @list.unshift(ele)
    end

    def dequeue
        @list.shift
    end

    def peek
        @list.first
    end

    def empty?
        @list.empty?
    end
end

class ComparativeHash
    def initialize(base=0)
        @base = base
        @list = Hash.new
    end

    attr_reader :base

    def add(num)
        #if it is not a key it will return nil
        @list[@base-num] = num
    end

    def [](key)
        @list[key]
    end

end


    def four_sum(arr, target)
        two_hash = Hash.new #ComparativeHash.new
        three_hash = Hash.new
        four_hash = Hash.new

        #three sum we need to create a sub target by subtratcing each ele from 
        #target if the sub target then has a two sum we know we have a three sum

        #likewise if we create a third tier deeper of targets we can check if they have a three sum.




        arr.each do |ele|
            #fill the hash
            two_hash[target - ele] = ele

            three_hash[(target - ele) - ele] = ele
            four_hash[((target - ele) - ele)- ele] = ele




            #hash_sum_pairs
        end

        # arr.each_with_index do |num, i|

        #     next if hash_map[num] == nil 
        #     #otherwise we know it is a pair
        #     hash_sum_pairs += 1
        # return true if hash_sum_pairs == 2
        # p
        # p two_hash
        # p
        # p three_hash
        # p
        # p four_hash
    end

    four_sum(arr, 13)
    