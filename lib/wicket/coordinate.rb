module Wicket
  class Coordinate < Struct.new(:x,:y)

    def distance_to(remote)
      ((remote.x - x) ** 2 + (remote.y - y) ** 2) ** 0.5
    end

  end
end