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

    def owner=(new_owner)
      raise BoxIncompleteError unless completed?
      raise BoxOwnerAlreadySetError if @owner
      @owner = new_owner
    end
    
    def completed?
      @edges.all? { |dir, status| status == :drawn }
    end
  end 

  class BoxIncompleteError < StandardError; end
  class BoxOwnerAlreadySetError < StandardError; end
end
