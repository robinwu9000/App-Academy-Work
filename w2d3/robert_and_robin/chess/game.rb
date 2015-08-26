require_relative 'board'
require_relative 'player'
require "yaml"

class Game
  attr_reader :start_pos, :player_w, :player_b, :board, :taken_pieces_w, :taken_pieces_b
  attr_accessor :previous_move, :current_player

  def initialize
    @board = Board.new(self)
    @player_w = Player.new(:white, @board, self)
    @player_b = Player.new(:black, @board, self)
    @start_pos = false
    @previous_move = [[0,0],[0,0], NullPiece]
    @current_player = player_w
    @taken_pieces_w = []
    @taken_pieces_b = []
    play
  end

  def save_game
    File.write("./save_game.yml", self.to_yaml)
    puts "Game saved"
  end

  def self.load_game
    YAML.load_file("./save_game.yml").play
  end

  def play
    until over?
      take_turn(current_player)
      self.current_player = other_player(current_player)
    end
    board.render
    puts "Someone won or you guys tied"
  end

  private

  def take_turn(current_player)
    end_pos = start_pos
    until start_pos != end_pos
      @start_pos = false
      @start_pos = get_start_pos(current_player)
      end_pos = get_end_pos(current_player, start_pos)
    end
    fancy_move_checks(start_pos, end_pos)
    self.previous_move = [start_pos, end_pos, board[start_pos].class]
    board.make_move(start_pos, end_pos)
    board[end_pos].has_been_moved
  end

  def fancy_move_checks(start_pos, end_pos)
    check_for_taking_piece(start_pos, end_pos)
    check_for_castle(start_pos, end_pos)
    check_for_enpassant(start_pos, end_pos)
    check_for_queen_pawn(start_pos, end_pos)
  end

  def check_for_taking_piece(start_pos, end_pos)
    if !end_pos.empty?
      taken_pieces_w << board[end_pos] if board[end_pos].color == :white
      taken_pieces_b << board[end_pos] if board[end_pos].color == :black
    end
  end

  def check_for_castle(start_pos, end_pos)
    #If the king is jumping, make the rook castle
    if board[start_pos].is_king?
      if start_pos[1] - end_pos[1] == -2
        board.make_move([start_pos[0], 7], [start_pos[0], 5])
      elsif start_pos[1] - end_pos[1] == 2
        board.make_move([start_pos[0], 0], [start_pos[0], 3])
      end
    end
  end

  def check_for_enpassant(start_pos, end_pos)
    backwards_dir = {:white => 1, :black => -1}
    if board[start_pos].class == Pawn
      if board[end_pos].empty? && diagonal_pawn_move(start_pos, end_pos)
        board.make_move(previous_move[1],
            [previous_move[1][0] + backwards_dir[board[previous_move[1]].color], previous_move[1][1]])
      end
    end
  end

  def check_for_queen_pawn(start_pos, end_pos)
    piece = board[start_pos]
    if piece.is_a?(Pawn) && [0,7].include?(end_pos[0])
      piece_choice = current_player.choose_piece
      case piece_choice
      when 'q'
        piece = Queen.new(piece.color, piece.position, board)
      when 'n'
        piece = Knight.new(piece.color, piece.position, board)
      when 'r'
        piece = Rook.new(piece.color, piece.position, board)
      when 'b'
        piece = Bishop.new(piece.color, piece.position, board)
      end
    end
    board[start_pos] = piece
  end

  def diagonal_pawn_move(start_pos, end_pos)
    start_pos[0] != end_pos[0] && start_pos[1] != end_pos[1]
  end

  def other_player(current_player)
    current_player == player_w ? player_b : player_w
  end

  def get_start_pos(player)
    input = player.get_pos
    until valid_first_pos?(input, player)
      input = player.get_pos
    end
    input
  end

  def get_end_pos(player, start_pos)
    input = player.get_pos
    until valid_second_pos?(input, start_pos)
      input = player.get_pos
    end
    input
  end

  def valid_first_pos?(input, player)
    !board[input].valid_moves.empty? && board[input].color == player.color
  end

  def valid_second_pos?(input, start_pos)
    board[start_pos].valid_moves.include?(input) || input == start_pos
  end

  def over?
    board.checkmate?(:black) || board.checkmate?(:white) ||
    board.stalemate?(:black) || board.stalemate?(:white)
  end
end

Game.new
