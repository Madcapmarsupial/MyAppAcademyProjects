require 'benchmark'
require 'io/console'
require_relative "../max_windowed_range/max_windowed_range.rb"

include Benchmark 



def run_naive(arrays)
    arrays.each do |array|
      array_to_test = array.dup
      naive_windowed_max_range(array_to_test, 3)
    end
end

def run_windmax(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    windowed_max_range(array_to_test, 3)
  end
end

def random_arr(n)
    Array.new(n) { rand(n) }
end

def performance_test(size, count)
    arrays_to_test = Array.new(count) { random_arr(size) }

    Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                        "Avg. naive:  ", "Avg. wind_max: ") do |b|
      naive_max = b.report("Tot. naive_max:  ") { run_windmax(arrays_to_test) }
      windmax = b.report("Tot. wind_max: ") { run_windmax(arrays_to_test) }
      [naive_max/count, windmax/count]
    end
end

def run_performance_tests(multiplier = 5, rounds = 3)
    [1, 10, 100, 1000, 10000].each do |size|
      size *= multiplier
      wait_for_keypress(
        "Press any key to benchmark sorts for #{size} elements"
      )
      performance_test(size, rounds)
    end
end

def wait_for_keypress(prompt)
  puts prompt
  STDIN.getch
end



run_performance_tests()
