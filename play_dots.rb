require_relative "lib/dots"

game = Dots::Game.new
game.interface = Dots::Interface.new

game.start

loop do 
  begin
    game.move
    puts
  rescue EOFError
    puts "\n\nThanks for playing"
    break
  end
end