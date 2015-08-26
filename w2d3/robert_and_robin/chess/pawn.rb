require_relative "pieces"

class Pawn < Piece
  attr_accessor :game

  def initialize(color, position, board, game)
    super(color,position,board)
    @game = game
    @direction = {white: -1, black: 1}[color]
  end

  def moves
    moves_forward_one + moves_forward_two + moves_diagonal + enpassant
  end

  def to_s
    color == :white ? "♙ " : "♟ "
  end

  private

  attr_reader :direction

  def moves_forward_one
    if board[[position[0] + direction, position[1]]].empty?
      [[direction + position[0], position[1]]]
    else
      []
    end
  end

  def moves_forward_two
    two_squares_forward = board[[position[0] + 2 * direction, position[1]]] if !moved?
    if !moved? && !moves_forward_one.empty? && two_squares_forward.empty?
      [[2 * direction + position[0], position[1]]]
    else
      []
    end
  end

  def moves_diagonal
    [[direction, 1], [direction, -1]].map do |dif|
      [position[0] + dif[0], position[1] + dif[1]]
    end.select do |pos_move|
      board.on_board?(pos_move) && board[pos_move].color == other_color
    end
  end

  def enpassant
    if game.previous_move[2] == Pawn
      prev_move_magnitude = game.previous_move[1][0] - game.previous_move[0][0]
      prev_move_h_distance = horizontal_distance(game.previous_move[1])
      if prev_move_magnitude.abs == 2 && prev_move_h_distance.abs == 1
        return [[position[0] + direction, position[1] + prev_move_h_distance]]
      end
    end
    []
  end

  def horizontal_distance(target_pos)
    target_pos[0] == position[0] ? (target_pos[1] - position[1]) : 0
  end
end
