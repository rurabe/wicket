module Wicket
  class Coordinate < Struct.new(:x,:y)
    include Cartesian

    # method for a reference point to create absolute coords from
    # relative measures.
    def absolutize(delta_x,delta_y)
      self.class.new(x + delta_x , y + delta_y)
    end

    def relativize(remote)
      [remote.x - x, remote.y - y]
    end

    def reflect(remote)
      x,y = relativize(remote)
      absolutize(-x,-y)
    end

    def ==(other)
      self.x == other.x && self.y == other.y
    end

    def inspect
      "{x: #{self.x.to_f},y: #{self.y.to_f}}"
    end

  end
end