require "Card"

class Deck
  def self.all_cards
    all_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end
    all_cards
  end

  attr_reader :cards

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def count
    cards.count
  end

  def take(n)
    raise "not enough cards" if count < n
    cards.shift(n)
  end

  def return(other_cards)
    cards.concat(other_cards)
  end

end
