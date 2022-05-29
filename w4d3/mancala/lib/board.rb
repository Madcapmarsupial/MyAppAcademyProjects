class Board
  attr_accessor :cups
  attr_reader :player1, :player2

  def initialize(name1, name2)
    @player1, @player2 = name1, name2
    @cups = Array.new(14) { [] }
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0...cups.length).each do |i|
      cups[i] += ([:stone] * 4) unless (i == 6 || i == 13)
    end
  end

  def valid_move?(start_pos)
    valid_range = (0..5).to_a + (7..12).to_a
    if !valid_range.include?(start_pos) 
      raise "Invalid starting cup"
    elsif cups[start_pos].empty? 
      raise "Starting cup is empty" 
    end
  end

  def make_move(start_pos, current_player_name)
    opponent_cup = (current_player_name == player1 ? 13 : 6)
    index = start_pos
    stone_count = cups[start_pos].length  
    cups[index].clear 
    
    while stone_count > 0
      index = ((index += 1) % cups.length)
      p index
      if index != opponent_cup
        cups[index] << :stone
        stone_count -= 1 
      end
    end
    render

    return self.next_turn(index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    cup = cups[ending_cup_idx]
    return :prompt if (ending_cup_idx == 6) || (ending_cup_idx == 13)
    return :switch if cup.length == 1
    return ending_cup_idx if cup.length > 1
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side_1= cups.slice(0..5)
    side_2 = cups.slice(7..12)
    return (side_1.all?(&:empty?) || side_2.all?(&:empty?) )
  end

  def winner
    return :draw if cups[6].length == cups[13].length
    cups[6].length > cups[13].length ? player1 : player2
  end
end
