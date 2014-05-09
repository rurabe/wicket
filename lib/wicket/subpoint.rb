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

  end
end