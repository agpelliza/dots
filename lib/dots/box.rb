module Dots
  class Box

    def initialize
      @edges = Hash[ :north, :not_drawn, 
                     :south, :not_drawn, 
                     :east, :not_drawn, 
                     :west, :not_drawn ]
    end    
    
    attr_reader :edges
    attr_accessor :owner

    def draw_edge(dir)
      @edges[dir] = :drawn
    end
  end
end
