module Wicket
  module Commands
    class C < Command
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
        @subpoints = []
      end

      # takes 3 coordinates in the form of {x: ..., y: ...}
      def evaluate_angle(start,mid,finish)
        
      end

      def evaluate_curve(t)
        Coordinate.new( *([:x,:y].map{|c| de_casteljau(c,t,*control_points) }) )
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
    end
  end
end