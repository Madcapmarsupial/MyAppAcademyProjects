module Slideable
   
   
    def horizontal_dirs
      HORIZONTAL_VERTICAL_DIRS
    end

    def diagonal_dirs
      DIAGONAL_DIRS
    end

   def slideable_moves
      move_list = []
      directions = move_dirs
      
      directions.each do |direction|
         dx, dy = direction
         move_list += grow_unblocked_move_in_dir(dx, dy)
      end
      move_list
   end

  private
    HORIZONTAL_VERTICAL_DIRS = [ [-1, 0], [1,0], [0,-1], [0, 1] ] 
    # dwn = [-1, 0]
    #     up = [1,0]
    #     left = [0,-1]
    #     right = [0, 1]

    DIAGONAL_DIRS = [[-1, 1], [1,-1], [-1,-1], [1, 1]] 
    # up_left = [1,-1]
    # dwn_right = [-1, 1]
    # dwn_left = [-1, -1]
    # up_right = [1, 1]


   def grow_unblocked_move_in_dir(dy, dx)
      y,x = pos 
      possible_moves = []
      while  true
         move = [y += dy, x += dx]
         return possible_moves if !move[0].between?(0, 7) || !move[1].between?(0, 7)            

         if board[move].empty?
            possible_moves << move
         elsif board[move].color == color
            return possible_moves
         else
            possible_moves << move
            return possible_moves
         end
      end
   
   end

end
