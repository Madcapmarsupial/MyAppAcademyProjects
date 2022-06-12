class Pawn < Piece

    def initialize(color=nil, board=nil, pos)
        super
    end

    def valid_moves
        forward_steps + side_attacks
    end

    def symbol
        :P
    end

    private

    def at_start_row?
        forward_dir == 1 ? (pos[0] == 1) : (pos[0] == 6)
    end

    def forward_dir
       color == "white" ? 1 : -1
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
        y, x = pos
        left, right = [y + forward_dir, x - 1], [y + forward_dir, x + 1]
        sides = []
        sides << left if board[left].color != color && !board[left].empty?
        sides << right if board[right].color != color && !board[right].empty?
        sides
    end 

end