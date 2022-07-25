def my_min(numbers)
    (0..numbers.length).each do |i|
        minimum = true
        num1 = numbers[i]
        (i+1...numbers.length).each do |j|
            num2 = numbers[j]
            minimum = false if num1 > num2
        end

        return num1 if minimum == true
    end
end

#O(n^2)   double nested loop  quadratic
# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)  # =>  -5



list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

def my_min_two(list)
    list.inject(list[0]) { |min, num|  num < min ? num : min }
end
# #O(n) linear
#p my_min_two(list)  # =>  -5


#O(n^3)
def largest_contiguous_subsum(list)
    sub_arrs = []

    (0...list.length).each do  |i|
        sub_arrs << [list[i]]
        inner_arr = Array.new([list[i]])
        
        (i+1...list.length).each do |j|
            inner_arr << list[j]
            clone = inner_arr.dup
            sub_arrs << clone
        end
    end

    sub_arrs.map(&:sum).max
end

#O(n) time complexity O(1) memory complexity
def largest_contiguous_subsum_2(list)
    current_sum = 0
    largest_sum = list[0]

    list.each do |ele|  
        if largest_sum < ele
            largest_sum = ele
            current_sum = ele
        else
            current_sum += ele
            if current_sum > largest_sum
                largest_sum = current_sum
            end
        end
    end

    largest_sum
end

list = [5, 3, -7]
p largest_contiguous_subsum_2(list)

list2 = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum_2(list2)

list3 = [-5, -1, -3]
p largest_contiguous_subsum_2(list3)