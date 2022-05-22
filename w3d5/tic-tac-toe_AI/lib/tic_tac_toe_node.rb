require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    if board.over?
     if board.winner == next_mover_mark
      return true
     elsif  board.winner == nil || board.winner == evaluator
      return false
     end
    end

     return self.children.any? { |child| child.losing_node?(evaluator) } 
  end

  def winning_node?(evaluator)
    if board.over?
      if board.winner == evaluator
       return true
      elsif  board.winner == nil || board.winner == next_mover_mark
       return false
      end
     end
 
      return self.children.any? { |child| child.winning_node?(evaluator) } 
  end

  def switch_mark  
    case next_mover_mark
      when nil
        return :o
      when :x
        return :o
      when :o
        return :x
      end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
     moves_list = []
     (0...board.rows.length).each do |i|
      (0...board.rows[i].length).each do |j|
        current_pos = [i, j]
        if board.empty?(current_pos)
          new_board = board.dup
          new_board[current_pos] = next_mover_mark 
          prev_move_pos = current_pos
          mark = switch_mark
          move = TicTacToeNode.new(new_board, mark, prev_move_pos) 
          moves_list << move 
        end
      end
     end
     moves_list
  end
end
