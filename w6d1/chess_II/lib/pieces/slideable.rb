module Slideable
   #need to figure out how Slideable ansd rook and piece interct 
   #move dirs is private  and may not be getting called
   #moves may not be getting defined?
   #what is the link?
   
    def horizontal_dirs
    end

    def diagonal_dirs
    end

   def moves
        #should return an array of places a Piece can move to.

        # The Slideable module can implement #moves, 
        # but it needs to know what directions a piece can move in (diagonal, horizontally/vertically, both). 
        # Classes that include the module Slideable (Bishop/Rook/Queen) 
        # will need to implement a method #move_dirs, which #moves will use.

      # valid_moves = []
      # valid_moves += horizontal_dirs if self.move_dirs.include?(:horizontal)
      # valid_moves += diagonal_dirs if self.move_dirs.include?(:diagonal)

      move_list = []

      directions = move_dirs
      
      directions.each do |direction|
         dx, dy = direction
         move_list << grow_unblocked_move_in_dir(dx, dy)
      end
      move_list
   end

  private
    #HORIZONTAL_DIRS = [] 
    # dwn = [-1, 0]
    #     up = [1,0]
    #     left = [0,-1]
    #     right = [0, 1]

    #DIAGONAL_DIRS = [] 
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

   # def move_dirs
   #    p "move dirs"
   # end
   
end
