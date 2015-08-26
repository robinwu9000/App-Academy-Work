#### Match 2 card game ######

class Card
  attr_accessor :value, :is_faceup

  def initialize(value)
    @value = value
    @is_faceup = false
  end

  def hide
    @is_faceup = false
  end

  def reveal
    @is_faceup = true
    @value
  end

  def to_s
    return is_faceup ? value : "*"
  end

  def ==(second_card)
    self.to_s == second_card.to_s
  end

end


class Board
  attr_accessor :grid, :rows, :cols

  def initialize(row, col)
    @grid = Array.new(row){Array.new(col)}
    @rows = row
    @cols = col
    self.populate
  end

  def populate
    cards = []
    num_cards = (rows * cols) / 2
    (1..num_cards).each do |num|
      cards.push(num)
      cards.push(num)
    end
    cards.shuffle!
    (0..rows-1).each do |row|
      (0..cols-1).each do |col|
        grid[row][col] = Card.new(cards.pop)
      end
    end
  end

  def render
    grid.each do |row|
      row.each do |card|
        print  "#{card.to_s} "
      end
      puts
    end
  end

  def won?
    grid.each do |row|
      row.each do |card|
        if card.is_faceup == false
          return false
        end
      end
    end
    return true
  end

  def reveal(position)
    grid[position[0]][position[1]].reveal
  end

end

class Game
  attr_reader :board, :player

  def initialize
    @player = player_type
    @board = Board.new(@player.rows, @player.cols)
    @previous_guess = nil
    @num_turns = 0
  end

  def player_type
    puts "Please choose the player type: Human[1] or AI[2]"
    choice = gets.chomp.to_i
    if choice == 1
      HumanPlayer.new
    elsif choice == 2
      AIPlayer.new
    else
      "Invalid choice, please enter either 1 or 2"
      player_type
    end
  end

  def play
    while !board.won? && @num_turns < 10 do
      system("clear")
      board.render
      puts "This is turn number #{@num_turns + 1}"
      puts "Please guess a position"
      position = @player.make_turn
      while !valid_move(position) do
        puts "Please guess a position"
        position = @player.make_turn
      end
      @player.info = board.grid[position[0]][position[1]].reveal
      make_guess(position)
    end

    if board.won?
      puts "Congratulations #{player.name}, you won!"
    else
      puts "You ran out of turns"
    end
  end

  def valid_move(position)
    if position[0] >= @board.rows || position[1] >= @board.cols
      puts "Guess is out of bounds. Please make a valid guess"
      return false
    elsif board.grid[position[0]][position[1]].is_faceup
      puts "That guess was already made. Please make a unique guess."
      return false
    else
      return true
    end
  end

  def make_guess(position)
    if @previous_guess == nil
      @previous_guess = position
    else
      matching = board.grid[@previous_guess[0]][@previous_guess[1]] ==
        board.grid[position[0]][position[1]]
      if !matching
        board.render
        sleep(3)
        board.grid[@previous_guess[0]][@previous_guess[1]].hide
        board.grid[position[0]][position[1]].hide
      end
      @num_turns += 1
      @previous_guess = nil
    end
  end

end

class HumanPlayer

  attr_reader :name, :rows, :cols

  def initialize
    puts "Please enter you name: "
    @name = gets.chomp
    game_size
  end

  def game_size
    valid = false
    while !valid do
      puts "Please enter the number of rows: "
      @rows = gets.chomp.to_i
      puts "please enter the number of cols: "
      @cols = gets.chomp.to_i
      if (rows * cols).odd?
        puts "Your grid size must have even number of cards. Please re-enter"
        valid = false
      else
        valid = true
      end
    end
  end

  def make_turn
    gets.chomp.split(",").map { |el| el.to_i }
  end

  def get_info
  end

end

class AIPlayer

  attr_reader :name, :rows, :cols, :matched, :unmatched, :info

  def initialize
    @name = "Computer"
    game_size
    @matched = []
    @unmatched = { }
    @available = []
    (0..rows-1).each { |row| (0..cols-1).each { |col| available.push([row, col]) } }
  end

  def game_size
    @rows = [4,6].sample
    @cols = rand(3) + 3
  end

  def make_turn
    if unmatched.empty?
      position = available.sample
      available.pop(sample)
    elsif
  end

end

g = Game.new
g.play
