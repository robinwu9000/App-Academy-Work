class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(color, position, board)
    @color, @position, @board = color, position, board
    @moved = false
  end

  def moved?
    moved
  end

  def has_been_moved
    @moved = true
  end

  def empty?
    false
  end

  def valid_moves
    moves.select do |move|
      #make_move returns old inhabitant of square
      previous_pos = position
      previous_square = board.make_move(position, move)
      check = board.in_check?(color)
      board.make_move(move, previous_pos, previous_square)
      !check
    end
  end

  def is_king?
    false
  end

  def other_color
    color == :white ? :black : :white
  end

  private
  attr_reader :board, :moved
end

class NullPiece < Piece
  def initialize(position)
    @position = position
  end

  def empty?
    true
  end

  def moves
    []
  end

  def valid_moves
    []
  end

  def to_s
    "  "
  end

  def color
    :nul
  end
end
