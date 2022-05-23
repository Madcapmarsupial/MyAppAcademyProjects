require_relative 'tic_tac_toe_node'
require 'byebug'
class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    game_node = TicTacToeNode.new(game.board, mark)
    nodes = game_node.children
    move = nil 
    nodes.each do |node|
      if node.winning_node?(mark)
        return node.prev_move_pos
      elsif node.losing_node?(mark) == false
        move = node.prev_move_pos
      end 
    end
    raise "Error -- NO MOVES" if move.nil?
    return move
  end

end


if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
