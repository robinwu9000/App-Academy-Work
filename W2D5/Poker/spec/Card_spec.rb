require 'rspec'
require 'Card'

describe Card do

  describe "#initialize" do
    suit, value = :spades, :ace
    let(:card1) { Card.new(suit, value) }
    it "should have it's value and a suit" do
      expect(card1.suit).to eq(suit)
      expect(card1.value).to eq(value)
    end
  end

  describe "#<=>" do
    let (:card1) { Card.new(:hearts, :three) }
    let (:card2) { Card.new(:clubs, :nine) }
    let (:card3) { Card.new(:clubs, :three) }

    it "should return -1 if card is lower" do
      expect(card1<=>card2).to eq(-1)
    end

    it "should return 1 if card is higher" do
      expect(card2<=>card1).to eq(1)
    end

    it "should return 0 if card is equal" do
      expect(card1<=>card3).to eq(0)
    end
  end

  describe "#suit_eql?" do
    let (:card1) { Card.new(:diamonds, :deuce) }
    let (:card2) { Card.new(:diamonds, :seven) }
    let (:card3) { Card.new(:hearts, :king) }

    it "should return whether two cards have the same suit" do
      expect(card1.suit_eql?(card2)).to eq(true)
      expect(card1.suit_eql?(card3)).to eq(false)
    end
  end

  describe "#to_s" do
    let (:card1) { Card.new(:clubs, :jack) }

    it "should print the value and then suit" do
      expect(card1.to_s).to eq("J♣")
    end
  end

end
