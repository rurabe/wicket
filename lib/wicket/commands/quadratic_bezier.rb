module Wicket
  module Commands
    module QuadraticBezier
      include BezierCurve

      def control_points
        [cursor_start,c1,cursor_end]
      end

      def c1
        @absolute ? Coordinate.new(@c1x,@c1y) : @cursor_start.absolutize(@c1x,@c1y)
      end
    end
  end
end