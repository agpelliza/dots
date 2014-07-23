module Dots
  class Box

    def self.[](*position)
      box = new
      box.position = position
      return box
    end

    def initialize
      @edges = Hash[ :north, :not_drawn, 
                     :south, :not_drawn, 
                     :east, :not_drawn, 
                     :west, :not_drawn ]
    end    
    
    attr_reader :edges, :owner
    attr_accessor :position

    def draw_edge(dir)
      @edges[dir] = :drawn
    end

    def owner=(new_owner)
      raise BoxIncompleteError unless completed?
      raise BoxOwnerAlreadySetError if @owner
      @owner = new_owner
    end
    
    def completed?
      @edges.all? { |dir, status| status == :drawn }
    end

    def lines 
      require "set"
      x,y = @position
      @lines ||= { :north => Set[[x,y+1],[x+1,y+1]],
                   :south => Set[[x,y],[x+1,y]],
                   :east  => Set[[x,y],[x,y+1]],
                   :west  => Set[[x+1,y],[x+1,y+1]]
       }
    end  
    
    def edge?(edge_coords)
      lines.key(edge_coords) || false
    end
  end 

  class BoxIncompleteError < StandardError; end
  class BoxOwnerAlreadySetError < StandardError; end
end
