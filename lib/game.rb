require "colorize"
require_relative "board"
require_relative "player"

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1".colorize(:blue), " X ".colorize(:blue))
    @player2 = Player.new("Player 2".colorize(:green), " O ".colorize(:green))
    @current_player = @player1
  end

  def play
    loop do
      @board.display
      take_turn

      if game_over?
        @board.display
        announce_winner

        break
      end

      switch_player
    end
  end

  private

  def take_turn
    move = nil
    loop do
      move = @current_player.make_move
      break if valid_move?(move)

      puts "Invalid move. Try again."
    end
    @board.update(move, @current_player.marker)
  end

  def valid_move?(move)
    return false unless move.to_i.between?(1, 9)

    # row, col = @board.position_with_indicies(move)
    row, col = @board.send(:position_with_indicies, move)
    @board.valid_move?(row, col)
  end

  def game_over?
    @board.winner?(@current_player.marker) || @board.full?
  end

  def announce_winner
    if @board.winner?(@current_player.marker)
      puts "#{@current_player.name} wins!"
    else
      puts "It's a draw!"
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
