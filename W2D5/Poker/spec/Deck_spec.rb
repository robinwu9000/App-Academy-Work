require "rspec"
require "Deck"

describe Deck do

  context "#initialize" do
    let(:deck1) {Deck.new}

    it "should have 52 cards when initialized" do
      expect(deck1.cards.length).to eq(52)
    end

    it "returns all cards without duplicates" do
      deduped_cards = deck1.cards
        .map { |card| [card.suit, card.value] }
        .uniq
        .count
      expect(deduped_cards).to eq(52)
    end

  end


  let(:cards) do
    cards = [
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
    ]
  end

  context "#count" do
    let(:deck1) { Deck.new(cards) }

    it "should count how many cards in deck" do
      expect(deck1.cards.count).to eq(3)
    end
  end

  context "#take" do
    let(:deck1) { Deck.new(cards) }

    it "should take n cards from the deck" do
      deck1.take(1)
      expect(deck1.cards.length).to eq(2)
    end

    it "should not take more cards than deck has" do
      expect do
        deck1.take(4)
      end.to raise_error("not enough cards")
    end
  end

  context "#return" do
    let(:more_cards) do
      [ Card.new(:hearts, :four),
        Card.new(:hearts, :five),
        Card.new(:hearts, :six) ]
    end

    let(:deck1) { Deck.new(cards) }
    it "should return cards back into deck" do
      deck1.return(more_cards)
      expect(deck1.cards.count).to eq(6)
    end

    it "should return cards to the bottom of the deck" do
      deck1.return(more_cards)
      expect(deck1.cards.drop(3)).to eq(more_cards)
    end
  end
end
