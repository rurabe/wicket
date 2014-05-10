module Wicket
  module Commands
    class C < Command
      attr_reader :subpoints
      ARGS = 6

      include BezierCurve

      def initialize(absolute,cursor_start,c1x,c1y,c2x,c2y,x,y,opts={})
        @absolute = absolute
        @cursor_start = cursor_start
        @c1x = c1x
        @c1y = c1y
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
        @opts = opts
        @subpoints = linearized_curve # Array
      end

      def control_points
        [cursor_start,Coordinate.new(@c1x,@c1y),Coordinate.new(@c2x,@c2y),cursor_end]
      end

      def proof
        puts "<svg viewbox=\"#{@cursor_start.x - 10} #{@cursor_start.y - 10} #{@subpoints.max_by(&:x).x + 10} #{@subpoints.max_by(&:y).y + 10}\">"
        puts "<path d=\"M#{@cursor_start.x} #{@cursor_start.y} C#{@c1x} #{@c1y} #{@c2x} #{@c2y} #{@x} #{@y}\" style=\"stroke:slateblue; fill:none;\"/>"

        @subpoints.each do |sb|
          puts "<circle cx=\"#{sb.x}\" cy=\"#{sb.y}\" r=\"2\" style=\"fill:turquoise \"/>"
        end
        @subpoints.sort_by(&:t).each_cons(2) do |(s1,s2)|
          puts "<path d=\"M#{s1.x} #{s1.y}L#{s2.x} #{s2.y}\" style=\"stroke: lawngreen\"/>"
        end
        puts "</svg>"
      end

      private

    end
  end
end