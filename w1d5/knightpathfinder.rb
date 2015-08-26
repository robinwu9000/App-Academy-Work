require_relative "polytreenode"

class KnightPathFinder
  attr_reader :start, :root
  def initialize(start)
    @start = start
    @visited_positions = []
    build_move_tree
  end

  def self.valid_moves(position)
    moves = [1, -1, 2, -2].permutation(2).select { |el| el.first.abs != el.last.abs}
    result = []
    moves.each do |move|
      moved = self.get_move(position, move)
      result << moved if in_board?(moved)
    end
    result
  end

  def self.get_move(position, move)
    [position[0] + move[0], position[1] + move[1]]
  end

  def self.in_board?(position)
    position.all? {|x| x.between?(0,7)}
  end

  def new_move_positions(position)
    moves = KnightPathFinder.valid_moves(position)
    result = []
    moves.each do |move|
      result << move if !visited?(move)
    end
  end

  def visited?(position)
    @visited_positions.include?(position)
  end

  def build_move_tree
    @root = PolyTreeNode.new(start)
    queue = []
    # move_tree = []
    queue << root
    @visited_positions << start
    until queue.empty?
      current = queue.shift
      # move_tree << current
      children = new_move_positions(current.value)
      children.each do |pos|
        next if visited?(pos)
        child_node = PolyTreeNode.new(pos)
        current.add_child(child_node)
        @visited_positions << pos
        queue << child_node
      end
    end
  end

  def find_path(end_pos)
    #p @root.bfs(end_pos)
    @root.bfs(end_pos).trace_path_back
  end
end

k = KnightPathFinder.new([0,0])
p k.find_path([6,5])
# p k.new_move_positions([3,3])
