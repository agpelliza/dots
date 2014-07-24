module Dots
  class Game
    attr_accessor :interface
    attr_reader :players, :grid
    
    def start
      @players = interface.get_players
      @turn = 0 
      rows, cols = interface.get_grid_size
      @grid = Dots::Grid.new(rows, cols)
    end
    
    def current_player
      @players[@turn]
    end
  end
end
