require_relative 'board'
require_relative 'display'

def loop
    b = Board.new 
    d = Display.new(b)
    while true
        d.render
        d.cursor.get_input
    end
end

loop




b.move_piece("white", [1,2], [2,2])
b.move_piece("black", [6,3], [4,3])
b.move_piece("white", [1,1], [3,1])
b.move_piece("black", [7,4], [3,0])
