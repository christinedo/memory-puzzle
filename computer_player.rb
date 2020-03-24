class ComputerPlayer
  attr_accessor :prev_guess

  def initialize(n)
    @known_cards = {}
    @matched_cards = {}
    @board_size = n
    @prev_guess = nil
  end

  def receive_revealed_card(position, value)
    @known_cards[position] = value
  end

  def receive_match(position_1, position_2)
    @matched_cards[position_1] = true
    @matched_cards[position_2] = true
  end

  def random_guess
    guess = [rand(@board_size), rand(@board_size)]
    until !@known_cards.has_key?(guess)
      guess = [rand(@board_size), rand(@board_size)]
    end
    guess
  end

  def knows_matches
    result = @known_cards.find do |pos_1, val_1|
      @known_cards.any? do |pos_2, val_2|
        (pos_1 != pos_2 && val_1 == val_2) && !(@matched_cards[pos_1] || @matched_cards[pos_2])
      end
    end
    result[0] if result
  end

  def matches_location
    result = @known_cards.find do |pos, val|
      pos != @prev_guess && val == @known_cards[@prev_guess]
    end
    result[0] if result
  end

  def first_guess
    knows_matches || random_guess
  end

  def second_guess
    matches_location || random_guess
  end

  def get_input
    @prev_guess ? second_guess : first_guess
  end
end