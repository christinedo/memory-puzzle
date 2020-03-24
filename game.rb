require_relative "card"
require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
  def initialize(player, n)
    @player = player
    @board = Board.new(n)
    @prev_guess = nil
  end

  def over?
    @board.won?
  end

  def flip_wrong_guess(position)
    @board[position].hide
    @board[@prev_guess].hide
  end

  def compare_guess(position)
    if @prev_guess
      if @board[position] == @board[@prev_guess]
        @board.render
        puts "That's a match!"
        sleep(1)
        @player.receive_match(position, @prev_guess)
      else
        @board.render
        puts "Whoops! Wrong guess."
        sleep(1)
        flip_wrong_guess(position)
      end
      @prev_guess = nil
      @player.prev_guess = nil
    else
      @prev_guess = position
      @player.prev_guess = position
    end
  end

  def make_guess(position)
    card_value = @board.reveal(position)
    @player.receive_revealed_card(position, card_value)
    compare_guess(position)
  end

  def turn
    @board.render
    input = @player.get_input
    make_guess(input)
  end

  def play
    @board.populate
    turn until over?
    @board.render
    puts "Hooray! You matched all the cards!"
  end
end