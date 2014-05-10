module Wicket
  module Commands
    module BezierCurve

      def evaluate_curve(t)
        x = de_casteljau(:x,t,*control_points)
        y = de_casteljau(:y,t,*control_points)
        Subpoint.new( x,y,t,self )
      end

      private

        def linearized_curve
          @subpoints = init_subpoints
          smooth(new_point(*@subpoints))
          @subpoints
        end

        def de_casteljau(axis,t,*points)
          n = (points.length - 1)
          points.each_with_index.inject(0) do |m,(p,i)|
            m + ( choose(n,i) * ((1-t) ** (n-i)) * (t ** i) * p.send(axis))
          end
        end

        def choose(n,k)
          (0...k).inject(1){ |m,i| (m * (n - i)) / (i + 1) }
        end

        def smooth(point)
          if point_needed?(point)
            smooth(new_point(point,point.previous_neighbor))
            if point_needed?(point)
              smooth(new_point(point,point.next_neighbor))
            end
          end
        end

        # is the angle more than the tolerance?
        def point_needed?(point)
          point.angle < Utilities.radians_tolerance(@opts)
        end

        def new_point(point,neighbor)
          evaluate_curve((point.t + neighbor.t)/2.0).tap do |np|
            @subpoints << np
          end
        end



        def init_subpoints
          [ Subpoint.from_coordinate(@cursor_start,0,self),
            Subpoint.from_coordinate(cursor_end,1,self) ]
        end

    end
  end
end