module Wicket
  module Commands
    module BezierCurve

      def evaluate_curve(t)
        x = de_casteljau(:x,t,*control_points)
        y = de_casteljau(:y,t,*control_points)
        Subpoint.new( x,y,t,self )
      end

      private

        def linearize!
          smooth(*@subpoints)
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

        def smooth(p1,p2)
          new_point = evaluate_curve((p1.t + p2.t)/2.0)
          if point_needed?(p1,new_point,p2)
            @subpoints << new_point
            smooth(p1,new_point)
            smooth(new_point,p2)
          end
        end

        # is the angle more than the tolerance?
        def point_needed?(p1,new_point,p2)
          angle = evaluate_angle(p1,new_point,p2)
          angle < ( 0.9 * Math::PI)
        end

        # This method evaluates the angle at p2 in radians (180 deg = pi)
        def evaluate_angle(p1,p2,p3)
          a = p2.distance_to(p1)
          b = p2.distance_to(p3)
          c = p1.distance_to(p3)
          Math.acos((a**2 + b**2 - c**2)/(2 * a * b))
        end

        def init_subpoints
          [ Subpoint.from_coordinate(@cursor_start,0,self),
            Subpoint.from_coordinate(cursor_end,1,self) ]
        end

    end
  end
end