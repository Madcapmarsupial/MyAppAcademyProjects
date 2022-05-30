# PHASE 2
def convert_to_int(str)
  Integer(str)
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]
COFFEES = ["latte", "machiatto", "doppio"]
def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif  COFFEES.include? maybe_fruit
    raise ArgumentError.new "hey!, that's not fruit!"
  else
    raise StandardError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin 
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue ArgumentError
    puts "I do like coffee, but feed me fruit!"
    retry
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)

  ensure 
    e = "E"
    e += ", name must not be blank" if name.length < 1
    e += ", years_known must be greater then 4" if yrs_known < 5
    e += ", past_time must not be blank" if fav_pastime.length < 1
    raise ArgumentError.new(e) if e != "E"

    @name = name
    #raise ArgumentError.new "years_known must be 5 or greater" if yrs_known < 5
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


