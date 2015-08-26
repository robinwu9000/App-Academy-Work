require "Card"
require "Deck"

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_to_hand(card_array)
    raise "Hand is full" if cards.length == 5
    @cards.concat(card_array)
  end

  def find_value
    value = 0
  end

  def empty?
    cards.empty?
  end

  def sort_cards
    @cards.sort
  end
end
