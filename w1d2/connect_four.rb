
require 'byebug'
class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(6) { Array.new(7,"*")}
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []= (pos, value)
    x,y = pos
    grid[x][y] = value
  end

  def drop_disc(col,disc)
    arr = grid.transpose[col]

    index = arr.rindex("*")
    self[[index, col]] = disc
  end

  def print_all
    @grid.each do |row|
      row.each do |cell|
        print "#{cell} "
      end
      puts
    end
  end

  def over?
    row = nil
    col = nil
    (0..5).to_a.each {|x| row = check_row(x) if check_row(x)}
    (0..6).to_a.each {|x| col = check_col(x) if check_col(x)}
    diag = check_diagonals

    row || col || diag
  end

  def check_row row_num
    num = 0
    #@grid[row_num] = ["x","x","x","x","o","*","o"]
    lookup = @grid[row_num].join.scan(/[xo]/)
    return false if lookup.empty?
    idx = @grid[row_num].index(lookup[0])
    disc = lookup[0]
    ((idx + 1)...@grid[row_num].length).each do |x|
      break if num == 3
      if self[[row_num,x]] == "*"
        num = 0
      elsif self[[row_num,x]] != disc
        num = 0
        disc = self[[row_num,x]]
      else
        num += 1
      end
    end
      num == 3 ?  disc : false
  end

  def check_col col_num
    num = 0
    tposed = @grid.transpose
    #tposed[col_num] = ["x","x","o","x","o","*","o"]
    lookup = tposed[col_num].join.scan(/[xo]/)
    return false if lookup.empty?
    idx = tposed[col_num].index(lookup[0])
    disc = lookup[0]
    ((idx + 1)...tposed[col_num].length).each do |x|
      break if num == 3
      if tposed[col_num][x] == "*"
        num = 0
      elsif tposed[col_num][x] != disc
        num = 0
        disc = tposed[col_num][x]
      else
        num += 1
      end
    end
      num == 3 ?  disc : false
  end

  def check_diagonals
    arr = diagonals.map {|row| row.map{|cell|  cell = self[cell] }}
    #puts arr.inspect
    #puts "get here"
    num = 0
    arr.each do |diag|
      #puts"in here"
      lookup = diag.join.scan(/[xo]/)
      #puts lookup.inspect
      next if lookup.empty?
      #puts lookup
      idx = diag.index(lookup[0])
      #puts idx.inspect
      disc = lookup[0]
      #puts disc
      #puts diag.inspect
      #puts idx + 1
      ((idx + 1)...diag.length).each do |x|
        #puts "get in here"
        return disc if num == 3

        if diag[x] == "*"
          num = 0
        elsif diag[x]!= disc
          num = 0
          disc = diag[x]
        else
          num += 1
        end
      end

    end
    false
  end

  def diagonals
    arr = []
    current_row= 1
    current_col= 0

    while current_col < 4 do
      current_diag = []
      row = 0
      col = current_col
      while row < 6 && col < 7 do
        current_diag.push([row, col])
        row += 1
        col += 1
      end
      arr.push(current_diag)
      current_col += 1
    end

    while current_row < 3 do
      current_diag = []
      row = current_row
      col = 0
      while row < 6 && col < 7 do
        current_diag.push([row, col])
        row += 1
        col += 1
      end
      arr.push(current_diag)
      current_row += 1
    end

    current_row = 3
    current_col = 0
    while current_row < 6 do
      current_diag = []
      row = current_row
      col = 0
      while row >= 0 && col < 7 do
        current_diag.push([row, col])
        row -= 1
        col += 1
      end
      arr.push(current_diag)
      current_row += 1
    end

    while current_col < 4 do
      current_diag = []
      row = 5
      col = current_col
      while row >= 0 && col < 7  do
        current_diag.push([row, col])
        row -= 1
        col += 1
      end
      arr.push(current_diag)
      current_col += 1
    end

    return arr.uniq
  end

end

class Game
  attr_reader :board
  attr_accessor :disc
  def initialize
    @board = Board.new
    @disc = "x"

  end

  def run
    disc = "x"
    #puts "X goes first"
  #  debugger
    #puts @board.over?
    until @board.over?
      @board.print_all
      input = prompt
      @board.drop_disc(input,@disc)
      alternate_disc

    end
    @board.print_all
    puts "#{@board.over?} wins!"
  end

  def alternate_disc
    @disc = (["x","o"] - [disc])[0]
  end

  def prompt
    print "Enter A Position > "
    input = gets.chomp.to_i
  end
end


#b = Board.new
#b.print_all
# b.drop_disc(3,"x")
# b.drop_disc(3,"o")
# b.drop_disc(3,"x")
# b.drop_disc(4,"x")
# b.print_all
# #p b.check_row 4
# #p b.check_col 5
# p b.check_diagonals
g = Game.new
g.run
