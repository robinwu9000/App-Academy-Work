require_relative "pieces"

class SlidingPiece < Piece
  def moves
    all_moves = []
    difs.each do |dif|
      next_pos = [position[0] + dif[0], position[1] + dif[1]]
      all_moves.concat(add_dif(next_pos, dif))
    end
    all_moves
  end

  private

  def add_dif(start_pos,dif)
    return [] if !board.on_board?(start_pos)
    if !board[start_pos].empty?
      if board[start_pos].color != color
        return [start_pos]
      else
        return []
      end
    else
      next_pos = [start_pos[0] + dif[0], start_pos[1] + dif[1]]
      [start_pos] + add_dif(next_pos, dif)
    end
  end
end

class Bishop < SlidingPiece
  def to_s
    color == :white ? "♗ " : "♝ "
  end

  private

  def difs
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end
end

class Rook < SlidingPiece
  def to_s
    color == :white ? "♖ " : "♜ "
  end

  private

  def difs
    [[1,0], [0,1], [-1,0], [0,-1]]
  end
end

class Queen < SlidingPiece
  def to_s
    color == :white ? "♕ " : "♛ "
  end

  private

  def difs
    [[1,1], [1,-1], [-1,1], [-1,-1],
    [1,0], [0,1], [-1,0], [0,-1]]
  end
end
