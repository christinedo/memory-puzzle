require "timeout"
require_relative "game"

print "Enter an even number to start the game: "
begin
  size = Timeout.timeout(4) do
    gets.chomp.to_i
  end
rescue Timeout::Error
  size = 4
end

until size.even?
  print "Invalid number! Pick an even number: "
  size = gets.chomp.to_i
end

memory = Game.new(ComputerPlayer.new(size), size) # change to HumanPlayer to play
system("clear")
puts "Starting Memory Puzzle..."
sleep(2)
memory.play