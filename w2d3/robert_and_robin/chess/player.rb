require "io/console"

class Player
  attr_reader :color
  attr_accessor :game

  def initialize(name = "Kasparov", color, board, game)
    @name, @color, @board, @game = name, color, board, game
  end

  def get_pos
    while true
      board.render
      puts "WASD to move, enter to choose position, sa(v)e, (l)oad, (q)uit"

      input = $stdin.getch.downcase.to_sym
      if [:w, :a, :s, :d].include?(input)
          board.move_cursor(input)
      elsif input == :v
        game.save_game
      elsif input == :l
        Game::load_game
        abort
      elsif input == :q
        abort("Goodbye")
      elsif input == :"\r"
        return board.cursor_position
      end
    end
  end

  def choose_piece
    puts "Choose: (q)ueen, (r)ook, (b)ishop, or k(n)ight"
    while true
      input = $stdin.getch.downcase
      return input if ['q', 'r', 'b', 'n'].include?(input)
    end
  end

  private
  attr_reader :board
end
