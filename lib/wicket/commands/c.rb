module Wicket
  module Commands
    class C < Command
      ARGS = 6

      include BezierCurve

      def initialize(absolute,cursor_start,subpath,opts,c1x,c1y,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @c1x = c1x
        @c1y = c1y
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
      end

      def control_points
        [cursor_start,Coordinate.new(@c1x,@c1y),Coordinate.new(@c2x,@c2y),cursor_end]
      end

      def to_svg
        "L #{subpoints.reject{|s| s.t == 0}.sort_by(&:t).map(&:to_svg).join(" ")}"
      end

    end
  end
end