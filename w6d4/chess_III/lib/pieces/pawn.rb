class Pawn < Piece

    def initialize(color=nil, board=nil, pos)
        super
    end

    def moves
        forward_steps + side_attacks
    end

    def symbol
        color == "black" ? :♟ : :♙
    end

    private

    def at_start_row?
        forward_dir == 1 ? (pos[0] == 1) : (pos[0] == 6)
    end

    def forward_dir
       color == "white" ? -1 : 1
    end

    def forward_steps
        y, x = pos
        dir = forward_dir
        next_step = [y + dir, x]
        steps = []
        steps << next_step if board[next_step].empty?
        steps << [y + (dir * 2), x] if at_start_row?
        steps
    end

    def side_attacks
        sides = []
        y, x = pos

        left = [y + forward_dir, x - 1]
        if @board.valid_pos?(left)
         sides << left if board[left].color != color && !board[left].empty?
        end

        right = [y + forward_dir, x + 1]
        if @board.valid_pos?(right)
            sides << right if board[right].color != color && !board[right].empty?
        end
        
        sides
    end 

end