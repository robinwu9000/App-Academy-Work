# Jesse Latimer & Robin Wu

require_relative 'player'
require_relative 'aiplayer'

class GhostGame

  attr_reader :fragment

  def initialize(number_of_players)
    @fragment = ""
    @dictionary = load_dictionary("dictionary.txt")
    @players = generate_players(number_of_players)
  end

  def load_dictionary(filename)
    File.readlines(filename).map(&:chomp)
  end

  def generate_players(number_of_players)
    players = []
    number_of_players.times do |i|
      puts "Enter of name for Player #{i + 1}. Press a number for AI."
      input = gets.chomp
      if input.to_i > 0
        players << AIPlayer.new("AI#{input}", @dictionary)
      else
        players << Player.new(input)
      end
    end
    players
  end

  def run
    until @players.count <= 1
      # system("clear")
      game_state
      puts "Start of a new round"
      play_round
      remove_losers
      # sleep(3)
      p @fragment
      @fragment = ""
    end
    puts "Congratulations #{@players[0].name}, you won."
  end

  def remove_losers
    losers = @players.select { |player| player.loss_string == "GHOST" }
    puts "#{losers.map(&:name).join(", ")} has/have been removed" unless losers.empty?
    @players.select! { |player| player.loss_string != "GHOST" }
  end

  def play_round
    i = 0
    until won?
      @fragment << take_turn(@players[i])
      i = (i + 1) % @players.count
    end
    @players[i - 1].increase_losses
  end

  def game_state
    puts "Current score:"
    @players.each { |player| puts "#{player.name}: #{player.loss_string}" }
    puts
  end

  def take_turn(player)
    input = player.guess(fragment)
    until valid_play?(input)
      player.alert_invalid_guess
      input = player.guess(fragment)
    end
    puts "#{player.name} guesses #{input}."
    input
  end

  def valid_play?(str)
    str =~ /^[a-z]$/ && in_dictionary?(str)
  end

  def in_dictionary?(str)
    @dictionary.each do |word|
      return true if word[0..(@fragment.length)] == (@fragment + str)
    end
    false
  end

  def won?
    @dictionary.include?(@fragment)
  end

end

print "Number of players: "
n = gets.chomp.to_i
g = GhostGame.new(n)
g.run
