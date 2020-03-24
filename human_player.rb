class HumanPlayer
  attr_accessor :prev_guess

  def initialize(n)
    @prev_guess = nil
  end

  def prompt
    print "Enter the position of the card you'd like to flip (e.g. '0,0'): "
  end

  def get_input
    prompt
    gets.chomp.split(",").map(&:to_i)
  end

  def receive_revealed_card(position, value)
  end

  def receive_match(position_1, position_2)
  end
end