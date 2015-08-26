require_relative 'pieces.rb'
require_relative "stepping_piece"
require_relative "sliding_piece"
require_relative "pawn"
require "colorize"

class Board
  attr_accessor :cursor_position, :game, :grid

  private

  CURSOR_DIR = {
    :w => [-1, 0],
    :a => [0, -1],
    :s => [1, 0],
    :d => [0, 1]
  }

  BACKGROUND_COLORS = { 0 => :green, 1 => :blue}

  PIECE_ORDER = [Rook, Knight, Bishop, Queen,
                King, Bishop, Knight, Rook]

  public

  def initialize(game)
    @game = game
    initialize_grid
    @cursor_position = [0,0]
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def empty?(pos)
    self[pos].empty?
  end

  def at_cursor
    self[cursor_position]
  end

  def render
    system("clear")
    puts "  #{('a'..'h').to_a.join(" ")}"
    @grid.each_with_index do |row, i|
      print "#{i + 1} "
      row.each_with_index do |square, j|
        color = BACKGROUND_COLORS[(i+j) % 2]
        if [i,j] == cursor_position
          print square.to_s.colorize(background: :yellow)
        elsif game.start_pos
          if [i,j] == game.start_pos
            print square.to_s.colorize(background: color , color: :red)
          elsif self[game.start_pos].valid_moves.include?([i,j])
            print square.to_s.colorize(background: :red)
          else
            print square.to_s.colorize(background: color)
          end
        else
          if self[cursor_position].valid_moves.include?([i,j])
            print square.to_s.colorize(background: :yellow)
          else
            print square.to_s.colorize(background: color)
          end
        end
      end
      line_end(i)
    end
    puts
  end

  def line_end(i)
    print "  "
    if i.between?(0,3)
      # print game.taken_pieces_b[(3 * i)..(3 * i + 3)].map(&:to_s).join(" ")
      game.taken_pieces_b.each_with_index { |piece, ind| print piece.to_s if ind / 4 == i }
    else
      game.taken_pieces_w.each_with_index { |piece, ind| print piece.to_s if ind / 4 == 7 - i }
    end
    puts
  end

  def in_check?(color, king_pos = nil) #takes king_pos for castle checking
    king_pos ||= find_king(color)
    @grid.flatten.reject do |piece|
      piece.color == color || piece.is_king?
    end.any? do |piece|
      piece.moves.include?(king_pos)
    end
  end

  def find_king(color)
    @grid.flatten.find {|piece| piece.is_king? && piece.color == color}.position
  end

  def move_cursor(direction)
    tentative_pos = []
    cursor_position.each_with_index do |pos, i|
      tentative_pos << pos + CURSOR_DIR[direction][i]
    end
    self.cursor_position = tentative_pos if on_board?(tentative_pos)
  end

  def on_board?(coord)
    coord.all? {|pos| pos.between?(0,7)}
  end

  def make_move(start_pos, end_pos, replace_piece = NullPiece.new(start_pos))
    previous_at_end = self[end_pos]
    self[end_pos] = self[start_pos]
    self[end_pos].position = end_pos
    self[start_pos] = replace_piece
    #returning for temporary movements, see Pieces#valid_moves
    previous_at_end
  end

  def stalemate?(color)
    @grid.flatten.select do |piece|
      piece.color == color
    end.all? { |piece| piece.valid_moves.empty?}
  end

  def checkmate?(color)
    stalemate?(color) && in_check?(color)
  end

  private

  def initialize_grid
    @grid = Array.new(8) {Array.new(8)}
    (0..7).each do |row|
      (0..7).each do |col|
        case row
        when 0
          @grid[row][col] = PIECE_ORDER[col].new(:black, [row,col], self)
        when 1
          @grid[row][col] = Pawn.new(:black, [row,col], self, game)
        when 2..5
          @grid[row][col] = NullPiece.new([row,col])
        when 6
          @grid[row][col] = Pawn.new(:white, [row,col], self, game)
        when 7
          @grid[row][col] = PIECE_ORDER[col].new(:white, [row,col], self)
        end
      end
    end
  end
end
