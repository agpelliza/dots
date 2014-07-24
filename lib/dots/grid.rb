module Dots
  class Grid
    require "set"

    def initialize(rows,cols)
      @rows, @cols = rows, cols
      @data = Set[]
       (@cols).times do |x|
         (@rows).times do |y|
            @data << Dots::Box[x,y]
          end
       end
    end

    attr_reader :rows, :cols
    
    def [](*coords)
      @data.select do |box|
        box.edge?(Set[*coords])
      end
    end

    def connect(*coords)
      boxes = self[*coords]
      completed_boxes = Set[]
      raise InvalidEdgeError if boxes.empty?
      boxes.each do |b|
        b.draw_edge(b.edge?(Set[*coords]))
        completed_boxes << b if b.completed?
      end
      return completed_boxes
    end
    
    def box_at(*coord)
      @data.find do |box|
        box.position.eql?(coord)
      end
    end
  end
  
  class InvalidEdgeError < StandardError; end
end