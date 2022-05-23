require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def losing_node?(evaluator)
    if board.over?
     return board.winner != evaluator && board.won?
    end

    if self.next_mover_mark == evaluator
      return self.children.all? { |child| child.losing_node?(evaluator)}
    else 
      return self.children.any? { |child| child.losing_node?(evaluator)}
    end
  end


  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves_list = []

    (0...board.rows.length).each do |i|
      (0...board.rows[i].length).each do |j|
        pos = [i, j]

        next unless board.empty?(pos)

        new_board = board.dup
        new_board[pos] = next_mover_mark 
        next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
        moves_list << TicTacToeNode.new(new_board, next_mover_mark, pos) 
 
      end
    end
    moves_list
  end
end



