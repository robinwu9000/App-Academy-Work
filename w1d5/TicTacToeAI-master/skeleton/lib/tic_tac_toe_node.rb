require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    return true if board.winner == opponent

    child_nodes = self.children
    if(evaluator != next_mover_mark)
      return true if child_nodes.any? { |child| child.winning_node?(opponent) }
    else
      return true if child_nodes.all? { |child| child.losing_node?(evaluator) }
    end
    false
  end

  def winning_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    return true if board.winner == evaluator

    child_nodes = self.children
    if(evaluator == next_mover_mark)
      return true if child_nodes.any? { |child| child.winning_node?(evaluator) }
    else
      true if child_nodes.all? { |child| child.winning_node?(evaluator) }
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    possible_moves = []
    children_nodes = []
    (0..2).each do |row|
      (0..2).each do |col|
        if @board[[row, col]].nil?
          possible_moves << [row, col]
        end
      end
    end

    possible_moves.each do |move|
      a = @board.dup
      a[move] = next_mover_mark
      children_nodes << TicTacToeNode.new(a, next_mover_mark == :o ? :x : :o, move)
    end

    children_nodes
  end
end
