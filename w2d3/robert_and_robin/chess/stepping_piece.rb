require_relative "pieces"

class SteppingPiece < Piece
  def moves
    difs.map do |dif|
      [position[0] + dif[0], position[1] + dif[1]]
    end.select do |move|
      board.on_board?(move) && board[move].color != color
    end
  end
end

class Knight < SteppingPiece
  def to_s
    color == :white ? "♘ " : "♞ "
  end

  private

  def difs
    [[1, 2], [1, -2],
      [2, 1], [2, -1],
      [-1, 2], [-1, -2],
      [-2, 1], [-2, -1]]
  end
end

class King < SteppingPiece
  def difs
    [[1,1], [1,-1], [-1,1], [-1,-1], [1,0], [0,1], [-1,0], [0,-1]]
  end

  def moves
    moved? || board.in_check?(color) ? super : super.concat(castle_options)
  end

  def is_king?
    true
  end

  def to_s
    color == :white ? "♔ " : "♚ "
  end

  private

  def castle_options
    check_left + check_right
  end

  def check_left
    left_one = [position[0], position[1] - 1]
    left_two = [position[0], position[1] - 2]
    left_three = [position[0], position[1] - 3]

    if [left_one, left_two, left_three].all? {|pos| board[pos].empty? } &&
                                      !board.in_check?(color, left_one) &&
                                     board[[position[0],0]].is_a?(Rook) &&
                                     !board[[position[0],0]].moved?
      [left_two]
    else
      []
    end
  end

  def check_right
    right_one = [position[0], position[1] + 1]
    right_two = [position[0], position[1] + 2]

    if  board[right_one].empty? &&
        board[right_two].empty? &&
        board[[position[0],7]].is_a?(Rook) &&
        !board.in_check?(color, right_one) &&
        !board[[position[0],7]].moved?
      [right_two]
    else
      []
    end
  end

end
