class AIPlayer

  attr_reader :name

  def initialize(name, dictionary)
    @name = name
    @losses = 0
    @dictionary = dictionary
    @letter_frequencies = Array.new(26, 0)
  end

  def guess(fragment)
    get_frequencies(fragment)
    best_choice = get_best_choice(fragment)
    clear_frequencies
    best_choice
  end

  def get_best_choice(fragment)
    good_choice = false
    until good_choice
      best_index = @letter_frequencies.each_with_index.max[1]
      best_choice = (best_index + 97).chr
      if @letter_frequencies.all? { |x| x == 0 }
        good_choice = true
        best_choice = ("a".."z").to_a.sample
      elsif @dictionary.include?(fragment + best_choice)
        @letter_frequencies[best_index] = 0
      else
        good_choice = true
      end
    end
    best_choice
  end

  def get_frequencies(fragment)
    @letter_frequencies.map!.with_index do |count, letter_as_i|
      letter = (letter_as_i + 97).chr
      @dictionary.each do |word|
        count += 1 if word[0..(fragment.length)] == (fragment + letter)
      end
      count
    end
  end

  def alert_invalid_guess
  end

  def increase_losses
    @losses += 1
  end

  def loss_string
    " GHOST"[0..@losses].strip
  end

  def clear_frequencies
    @letter_frequencies = Array.new(26, 0)
  end

end
