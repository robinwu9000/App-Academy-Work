require "rspec"
require "Hand"

describe Hand do

  context "#initialize" do
    let (:hand1) { Hand.new }
    it "should not have any cards upon initialization" do
      expect(hand1.cards).to eq([])
    end
  end

  context "#add_to_hand" do
    let(:hand1) { Hand.new }

    let(:first_hand) {[
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
      ]}

    let(:more_cards) { [
      Card.new(:hearts, :four),
      Card.new(:hearts, :five),
      Card.new(:hearts, :six)
      ] }


    it "should be able to update the hand" do
      hand1.add_to_hand(first_hand)
      expect(hand1.cards).to eq(first_hand)
    end

    it "should only have 5 cards max" do
      hand1.add_to_hand(first_hand)
      expect do
        hand1.add_to_hand(more_cards)
      end.to raise_error("Hand is full")
    end

  end

  context "#find_value" do
    let(:hand1) { Hand.new }

    let(:first_hand) {[
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
      ]}
      #straight flush = 9 .. high card = 1
    it "should know it's own value" do
      hand1.add_to_hand(first_hand)
      expect(hand1.find_value).to eq(6)
    end
  end

  context "#beats?" do
    let(:hand1) { Hand.new }
    let(:hand2) { Hand.new }
    let(:first_hand) {[
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
      ]}

    let(:second_hand) {[
      Card.new(:hearts, :four),
      Card.new(:hearts, :five),
      Card.new(:hearts, :six),
      Card.new(:hearts, :seven),
      Card.new(:hearts, :eight)
      ]}

    it "should know it beats another hand" do
      hand1.add_to_hand(first_hand)
      hand2.add_to_hand(second_hand)

      expect(hand1.beats?(hand2)).to eq(true)
    end
  end

  context "#drop_cards" do
    let(:hand1) { Hand.new }

    let(:first_hand) {[
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
      ]}

    it "should be able to drop up to three cards" do
      hand1.add_to_hand(first_hand)
      hand1.drop_cards([1,2,3])
      expect(hand1.cards).to eq(first_hand[3..4])
    end

  end

  # it "should sort by value"
  # it "should know if it has a flush"



end
