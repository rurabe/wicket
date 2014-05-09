module Wicket
  module Commands
    class C < Command
      attr_reader :subpoints
      ARGS = 6

      include BezierCurve

      def initialize(absolute,cursor_start,c1x,c1y,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @c1x = c1x
        @c1y = c1y
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
        @subpoints = init_subpoints # Array
      end

      def control_points
        [cursor_start,Coordinate.new(@c1x,@c1y),Coordinate.new(@c2x,@c2y),cursor_end]
      end

      private

        def init_subpoints
          [ Subpoint.from_coordinate(@cursor_start,0,self),
            Subpoint.from_coordinate(cursor_end,1,self) ]
        end
    end
  end
end