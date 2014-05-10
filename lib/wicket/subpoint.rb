module Wicket
  class Subpoint < Struct.new(:x,:y,:t,:command)

    def self.from_coordinate(coordinate,t,command)
      new(coordinate.x,coordinate.y,t,command)
    end

    def distance_to(remote)
      Math.sqrt((remote.x - x) ** 2 + (remote.y - y) ** 2)
    end

    def siblings
      command.subpoints
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
      a = p2.distance_to(p1)
      b = p2.distance_to(p3)
      c = p1.distance_to(p3)
      Math.acos((a**2 + b**2 - c**2)/(2 * a * b))
    end

  end
end