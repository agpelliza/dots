module Dots
  class Grid
    def initialize(rows,cols)
      @rows, @cols = rows, cols
      @data = Set[]
       (@cols).times do |x|
         (@rows).times do |y|
            @data << Dots::Box[x,y]
          end
       end
    end
    
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
      Game.filled_boxes(completed_boxes) unless completed_boxes.empty?
    end
    
    def box_at(*coord)
      @data.find do |box|
        box.position.eql?(coord)
      end
    end
  end
  
  class InvalidEdgeError < StandardError; end
end