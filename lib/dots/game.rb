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
      @players[@turn % @players.length]
    end

    def move
      coords = interface.get_move
      completed = @grid.connect(*coords)
      if completed.empty?
        @turn += 1 
      else
        completed.size
      end
    end
  end
end
