#Problem 1: 

def sum_recur(array)
    return array.pop if array.length == 1
    num = array.pop
     num + sum_recur(array) 
end

#Problem 2: 

def includes?(array, target)
    return true if array.last == target
    return false if array.length == 1

    array.pop
    return includes?(array, target)
end

# Problem 3: 

def num_occur(array, target)
    return 0 if array.empty? 
    num = array.pop
    return 1 + num_occur(array, target) if num == target
    return 0 + num_occur(array, target)
end

# Problem 4: 

def add_to_twelve?(array)
    return false if array.length == 1
    pair_sum = sum_recur(array.slice(-2..-1))
    return true if pair_sum == 12
    array.pop
    add_to_twelve?(array)
end

# Problem 5: 

def sorted?(array)
   return false if array[-1] < array[-2]
    return true if array.length == 2
    
    sorted?(array.slice(0...-1))
end

# Problem 6: 

def reverse(string)
    return string if string.length == 1
    string[-1] += reverse(string[0...-1])
end
