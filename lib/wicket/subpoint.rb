module Wicket
  class Subpoint < Struct.new(:x,:y,:t,:siblings)
    include Cartesian

    def self.from_coordinate(coordinate,t,siblings)
      new(coordinate.x,coordinate.y,t,siblings)
    end

    def initialize(x,y,t,siblings)
      super(x,y,t,siblings)
      siblings << self
    end

    def previous_neighbor
      siblings.select{|s| s.t < t }.max_by(&:t)
    end

    def next_neighbor
      siblings.select{|s| s.t > t }.min_by(&:t)
    end

    def angle
      evaluate_angle(previous_neighbor,self,next_neighbor) unless endpoint?
    end

    def endpoint?
      t == 0 || t == 1
    end

    # This method evaluates the angle at p2 in radians (180 deg = pi)
    def evaluate_angle(p1,p2,p3)
      if straight_line?(p1,p2,p3)
        Math::PI
      else
        a = p2.distance_to(p1)
        b = p2.distance_to(p3)
        c = p1.distance_to(p3)
        Math.acos((a**2 + b**2 - c**2)/(2 * a * b))
      end
    end

    private

      def straight_line?(p1,p2,p3)
        ((p1.x == p2.x) && (p2.x == p3.x)) || ((p1.y == p2.y) && (p2.y == p3.y))
      end

  end
end