# O(n^2) quadractic time
# O(1) constant space
def brute_two_sum?(arr, target_sum)
    (0...arr.length).each do |i| 
        (i+1...arr.length-1).each do |j|
            return true if arr[i] + arr[j] == target_sum
        end
    end
    return false
end

brute_two_sum?(arr, 6) # => should be true
brute_two_sum?(arr, 10) # => should be false


def merge(left, right)
    return right if left.empty? 
    return left if right.empty?

    if left.first < right.first
        smaller = [left.shift]
    else 
        smaller = [right.shift]
    end

   sorted_arr = merge(left, right)
   smaller += sorted_arr
end

def my_sort(arr)
  return arr if arr.length <= 1

    half = arr.length / 2
    r = arr.drop(half)
    l = arr.take(half)
    merge(my_sort(l), my_sort(r))

end

def binary(num, arr)

    return arr.last if arr.last == num
    return nil if arr.length == 1
    half = arr.length / 2
    left = arr.take(half)
    right = arr.drop(half)

    if left.last < num
        return binary(num, right)
    else 
       return binary(num, left)
    end
end

#O(n log n)  log linear due to the sorting
# binary is O(log n) logarithmic
def okay_two_sum?(arr, target_sum)
   arr.each_with_index do |ele, i| 
        target_diff = (target_sum - ele)
        copy = arr.dup
        copy.delete_at(i)
        target = binary(target_diff, copy)
        return true if target !=nil
   end
   false
end

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

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false
