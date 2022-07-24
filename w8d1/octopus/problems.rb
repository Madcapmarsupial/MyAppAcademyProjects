fish_list = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
#=> "fiiiissshhhhhh"
require 'io/console'
require 'benchmark'


def sluggish(fish)
    i = 0
    longest = nil
    while i <= fish.length - 1
        fish_one = fish[i]

        j = i + 1

        while j <= fish.length - 1
            fish_two = fish[j]
            fish_one.length > fish_two.length ? longest = fish_one : longest = fish_two
            j += 1
        end
        i += 1
    end

    longest
end

def dominant(fish)
    if fish.length <= 1
        return fish
    end 

    half = fish.length / 2
    pick(dominant(fish.take(half)), dominant(fish.drop(half)))
end

def pick(l, r)
    unless l.empty? || r.empty?
        if l.first.length > r.first.length
            l
        else
            r
        end
    end 
end

def compare(fish, other_fish)
    selection = fish.length <=> other_fish.length
    case selection
    when 1 then fish
    when 0 then fish
    when -1 then other_fish
    end
end

def clever(fishies)
    fishies.inject(fishies[1]) { |held_fish, fish| compare(fish, held_fish) }
end

def slow_dance(dir, tiles)
    tiles.each_with_index do |tile, i|
        return i if tile == dir
    end

end

tiles_hash = {"up" => 0, "right-up" => 1, "right" => 2, "right-down" => 3,
     "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7 }

def constant_dance(dir, tiles)
    tiles[dir]
end

