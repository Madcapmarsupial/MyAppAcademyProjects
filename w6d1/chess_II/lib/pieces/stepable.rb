module Stepable 

    def valid_pos(position)
        return false if board[position].color == color
        return false if !position[0].between?(0, 7) || !position[1].between?(0, 7)
        true
    end 

    def moves
        y, x = pos 
        possible_moves = []
        move_diffs.each do |dir|
            dy, dx = dir[0], dir[1] 
            move = [dy + y, dx + x ]
            if valid_pos(move)
                possible_moves << move
            end
        end

        possible_moves
    end

    # private 
    #     def move_diffs

    #     end
end