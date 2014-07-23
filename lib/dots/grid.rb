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
  end
end