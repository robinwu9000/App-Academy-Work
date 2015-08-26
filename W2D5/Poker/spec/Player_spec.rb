require "Player"
require "rspec"

describe Player do

  context "#initialize" do
    let(:hand) { double('hand') }
    subject(:player1) { Player.new(hand, pot = 100) }

    it "should have a hand" do
      expect(player1.hand).to_not be_nil
    end

    it "should have a pot" do
      expect(player1.pot).to eq(100)
    end

  end

  context "#raise" do
    let(:hand) { double('hand') }
    subject(:player1) { Player.new(hand, pot = 100) }

    it "should deduct the amount from the pot when user makes a bet" do
      player1.raise(20)
      expect(player1.pot).to eq(80)
    end

    it "should not be able to make illegal bet (higher bet than pot value)" do
      expect do
        player1.raise(200)
      end.raise_error "Don't have enough funds"
    end

  end

  context "#call" do
    let(:hand) { double('hand') }
    subject(:player1) { Player.new(hand, pot = 100) }
    let(:game1) { double('game', :previous_bet => 20) }

    it "should receive value from Game class about last bet" do
      expect(player1).to receive(:call).with(20)
      player1.call(game.previous_bet)

    end

    it "should deduct when user calls" do
      player1.call(20)
      expect(player1.pot).to eq(80)
    end

    it "pot shouldn't go below zero" do
      player1.call(200)
      expect(player1.pot).to eq(0)
    end
  end

  context "#fold" do
    let(:first_hand) {[
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :king),
      Card.new(:spades, :queen),
      Card.new(:spades, :jack)
      ]}
    let(:hand) { double('hand', :cards => first_hand) }
    subject(:player1) { Player.new(hand, pot = 100) }

    it "should have an empty hand if folded" do
      player1.fold
      expect(player1.hand.empty?).to eq(true)
    end
  end

  context "#discarded_cards" do
    let(:hand) { double('hand') }
    subject(:player1) { Player.new(hand, pot = 100) }

    it "should return an array" do
      expect(player1.discarded_cards).to be_an(Array)
    end

    it "should sanitize the user input properly" do
      expect(player1.discarded_cards.count).to be < 4
      player1.discarded_cards.should not_include (
        a_value > 4,
        a_value < 0
      )
    end
  end

end
