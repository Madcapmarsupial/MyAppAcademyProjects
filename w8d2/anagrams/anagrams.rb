require 'io/console'
require 'benchmark'

def first_anagram?(str, str_2)
    word_list = str.split("").permutation(str.length).to_a
    word_list.include?(str_2)

end

p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("zealotized", "renderized") 
p "------------"


#O(n^2)
def secound_anagram?(str1, str2)
    char_indexes = str2.split("")

    str1.each_char do |char|
        index = char_indexes.find_index(char)
        return false if index == nil
        char_indexes.delete_at(index)
    end

    return char_indexes.empty?
end

p secound_anagram?("gizmo", "sally")    #=> false
p secound_anagram?("renderizedzealotizedrenderizedzealotized", "renderizedzealotized") 
p "------------"



def third_anagram?(str1, str2)
    #O(n)
    return str1.split("").sort == str2.split("").sort
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("zealotizedzealotizedzealotizedzealotized", "renderizedzealotized") 
p "------------"



#arrays_to_test = Array.new(count) { random_arr(size) }

    # Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
    #                     "Avg. Merge:  ", "Avg. Bubble: ") do |b|
    #   merge = b.report("Tot. Merge:  ") { run_merge_sort(arrays_to_test) }
    #   bubble = b.report("Tot. Bubble: ") { run_bubble_sort(arrays_to_test) }
    #   [merge/count, bubble/count]
    # end