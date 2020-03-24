require_relative 'card'

class Board
  def self.print_grid(arr)
    arr.each { |row| puts row.join(" ") }
  end

  def initialize(n)
    @grid = Array.new(n) { Array.new(n) }
    @size = n * n
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def num_cards
    @grid.flatten.count { |ele| ele.instance_of? Card }
  end

  def empty_position?(position)
    !self[position].instance_of?(Card)
  end

  def populate
    card_values = ("A".."Z").to_a.sample(@size / 2)
    while num_cards < @size
      pos = [rand(@grid.length), rand(@grid.length)]
      if empty_position?(pos)
        self[pos] = Card.new(card_values[0])
        card_values.rotate!
      end
    end
  end

  def hidden_cards_grid
    @grid.map do |row|
      row.map { |card| card.face_up ? card.face_value : "@" }
    end
  end

  def render
    system("clear")
    self.class.print_grid(hidden_cards_grid)
  end

  def reveal(guessed_position)
    card = self[guessed_position]
    card.show if !card.face_up
    card.face_value
  end

  def won?
    @grid.flatten.all? { |card| card.face_up }
  end

  def cheat
    self.class.print_grid(@grid)
  end
end