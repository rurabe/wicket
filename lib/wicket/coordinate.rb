module Wicket
  class Coordinate < Struct.new(:x,:y)
    include Cartesian

    # method for a reference point to create absolute coords from
    # relative measures.
    def absolutize(delta_x,delta_y)
      self.class.new(x + delta_x , y + delta_y)
    end

  end
end