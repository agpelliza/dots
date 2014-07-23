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
      edges = self[*coords]
      raise InvalidEdgeError if edges.empty?
      edges.each do |b|
        b.draw_edge(b.edge?(Set[*coords]))
      end
    end
    
    def box_at(*coord)
      @data.find do |box|
        box.position.eql?(coord)
      end
    end
  end
  
  class InvalidEdgeError < StandardError; end
end