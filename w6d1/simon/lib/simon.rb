class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until @game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if game_over == false
      @sequence_length += 1
      round_success_message
    end
  end

  
  def show_sequence
    add_random_color
    seq.each do |color| 
      print color + "\n"
      sleep(1)
    end
    system("clear")

  end

  def require_sequence
    @seq.each do |color|
      answer = gets.chomp
       unless answer == color
        @game_over = true
        break
       end
    end
    system("clear")
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    p "good job"
    sleep(1)
    system("clear")
  end

  def game_over_message
    p "game over"
  end

  def reset_game
    @seq = []
    @game_over = false
    @sequence_length = 1
    system("clear")
    p "New Game"
    sleep(2)
    self.play
  end
end
