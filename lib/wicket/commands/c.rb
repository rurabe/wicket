module Wicket
  module Commands
    class C < Command
      attr_reader :subpoints
      def self.arg_count
        6
      end

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

      def linearize!
        @subpoints.each_slice(2) do |(prev,next)|
          # create the midpoint, and evaluate the angle created
          # if the angle meets the threshold, add it to the subpoints array
        end
      end

      def evaluate_curve(t)
        Subpoint.new( *([:x,:y].map{|c| de_casteljau(c,t,*control_points) }),t,self )
      end

      def control_points
        [cursor_start,Coordinate.new(@c1x,@c1y),Coordinate.new(@c2x,@c2y),cursor_end]
      end

      private

        def de_casteljau(attribute,t,*points)
          n = (points.length - 1)
          points.each_with_index.inject(0) do |m,(point,i)|
            m + ( choose(n,i) * ((1-t) ** (n-i)) * (t ** i) * point.send(attribute))
          end
        end

        def choose(n,k)
          (0...k).inject(1){ |m,i| (m * (n - i)) / (i + 1) }
        end

        def init_subpoints
          [ Subpoint.from_coordinate(@cursor_start,0,self),
            Subpoint.from_coordinate(cursor_end,1,self) ]
        end
    end
  end
end