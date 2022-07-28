require 'io/console'
require 'benchmark'

#O(n!)
def first_anagram?(str, str_2)
    word_list = str.split("").permutation(str.length).to_a
    word_list.include?(str_2)

end


#O(n^2)
def second_anagram?(str1, str2)
    char_indexes = str2.split("")

    str1.each_char do |char|
        index = char_indexes.find_index(char)
        return false if index == nil
        char_indexes.delete_at(index)
    end

    return char_indexes.empty?
end

#O(nlogn)   
def third_anagram?(str1, str2)
    return str1.split("").sort == str2.split("").sort
end

#O(n)
def fourth_anagram?(str1, str2)
    hash_1 = Hash.new {|h, k| h[k] = 0 }
    str1.each_char { |char| hash_1[char] += 1 }
    str2.each_char { |char| hash_1[char] += 1 }

    hash_1.each_pair { |k, v| return false if v.odd? }
    true
    
    
end