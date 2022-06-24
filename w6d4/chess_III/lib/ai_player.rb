require_relative 'display'
require_relative 'player'

class Ai_Player < Player
    def initialize(color, display)
        super
    end

    def make_move(board)
        pieces = find_movable_pieces(board)

        if pieces.none?(&:has_captures?)
            #if no capture availble random move
            piece = random_move(pieces)
            end_pos = piece.valid_moves.sample
        else
            #random capture
            piece = get_capturers(pieces).sample
            end_pos = piece.get_captures.sample
        end

        start = piece.pos
        board.move_piece(color.to_s, start, end_pos)
    end

    private
    
    def random_move(pieces)
        pieces.sample
    end

    def get_capturers(pieces)
        pieces.select {|piece| piece.has_captures? }
    end

    def find_movable_pieces(board)
        owned_pieces = board.pieces.select { |piece| piece.color == color.to_s }
        owned_pieces.select! {|piece| piece.valid_moves.length > 0 }
    end

#implement piece scoring and make moves based on that 
#prioritize forks 
#prioritize moves that are backed up
#which threaten higher value pieces
#else random

#build in scripted openings and pick randomly from one
# build in scripted reactions
#move tree?



end