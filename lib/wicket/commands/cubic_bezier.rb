module Wicket
  module CubicBezier

    def control_points
      [cursor_start,c1,c2,cursor_end]
    end

    def c1
      @absolute ? Coordinate.new(@c1x,@c1y) : @cursor_start.absolutize(@c1x,@c1y)
    end

    def c2
      @absolute ? Coordinate.new(@c2x,@c2y) : @cursor_start.absolutize(@c2x,@c2y)
    end
  
  end
end