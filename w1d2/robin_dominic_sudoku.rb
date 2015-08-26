### Sudoku #####
require "colorize"


class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    given ? value.to_s.colorize(:white) :  value.to_s
  end

end



class Board
  attr_accessor :grid


  def initialize
    @grid = []
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []= (pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def update_tile(pos, value)
    if self[pos].given == false
      self[pos].value = value
    else
      puts "You can't change that value"
    end
  end

  def from_file(file)
    numbers = File.readlines(file)
    numbers.each do |line|
      tiles = (line.chomp.split("")).map { |e| e.to_i }
      tile_array = []
      tiles.each do |tile_value|
        if tile_value != 0
          tile_array.push(Tile.new(tile_value, true))
        else
          tile_array.push(Tile.new(0, false))
        end
      end
      @grid.push(tile_array)
    end
  end

  def render
    grid.each do |rows|
      rows.each do |tile|
       print  tile.to_s
      end
      puts
    end
  end

  def solved?
    is_solved = true
    (0..8).each do |i|
      is_solved = is_solved && check_square(i)
      is_solved = is_solved && check_row(i)
      is_solved = is_solved && check_col(i)
    end

    return is_solved
  end

  def check_row(row)
    temp = grid[row].map {|el| el.value}
    temp.inject(:+) == 45 && temp.uniq.length == 9
  end

  def check_col(col)
    temp = grid.transpose[col].map {|el| el.value}
    temp.inject(:+) == 45 && temp.uniq.length == 9
  end

  def check_square(square)
    ranges = { 0 => [(0..2), (0..2)], 1 => [(3..5), (0..2)], 2 => [(6..8), (0..2)],
               3 => [(0..2), (3..5)], 4 => [(3..5), (3..5)], 5 => [(6..8), (3..5)],
               6 => [(0..2), (6..8)], 7 => [(3..5), (6..8)], 8 => [(6..8), (6..8)]}

    box = []
    ranges[square][0].each do |rows|
      ranges[square][1].each do |cols|
        box << self[[rows,cols]].value
      end
    end
    box.inject(:+) == 45 && box.uniq.length == 9

  end

end

class Game
  def initialize
    @board = Board.new
    @board.from_file("./puzzles/sudoku1-almost.txt")
  end

  def play
    until @board.solved?
      @board.render
      input = prompt
      until isvalid?(input)
        input = prompt
      end
      @board.update_tile(input[0],input[1])

    end
    puts "You Win!"
    @board.render
  end

  def prompt
    print "Enter a position 1,3 > "
    input = gets.chomp.split(",").map{|x| x.to_i}
    print "Enter a value > "
    value = gets.chomp.to_i
    [input,value]
  end

  def isvalid? input
    #puts @board[input[0]].given
    #puts @board[input[1]]
     input[0].all? {|x| x.between?(0,8)}  && !(@board[input[0]].given) &&
      input[1].is_a?(Fixnum)

  end


end

g = Game.new
g.play
