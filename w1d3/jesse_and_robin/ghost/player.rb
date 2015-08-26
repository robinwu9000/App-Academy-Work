class Player

  attr_reader :name

  def initialize(name)
    @name = name
    @losses = 0
  end

  def guess(options = {})
    puts "What's your letter, #{name}?"
    input = gets.chomp.downcase
  end

  def alert_invalid_guess
    puts "Input must be a single letter and create a valid word fragment."
  end

  def increase_losses
    @losses += 1
  end

  def loss_string
    " GHOST"[0..@losses].strip
  end

end
