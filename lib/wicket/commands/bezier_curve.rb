module Wicket
  module Commands
    module BezierCurve

      def evaluate_curve(t)
        x = de_casteljau(:x,t,*control_points)
        y = de_casteljau(:y,t,*control_points)
        [x,y,t]
      end

      def to_wkt(opts={})
        o = @opts.merge(opts)
        subpoints(o).reject{|s| s.t == 0 }.map{|s| s.to_wkt(o) }.join(",")
      end

      def to_svg(opts={})
        o = @opts.merge(opts)
        "L #{subpoints(o).reject{|s| s.t == 0}.map{|s| s.to_svg(o) }.join(" ")}"
      end

      private

        def subpoints(opts)
          points = init_subpoints
          smooth(points,new_point(points,*points),opts)
          points.sort_by(&:t)
        end

        def de_casteljau(axis,t,*points)
          points
          n = (points.length - 1)
          points.each_with_index.inject(0) do |m,(p,i)|
            m + ( choose(n,i) * ((1-t) ** (n-i)) * (t ** i) * p.send(axis))
          end
        end

        def choose(n,k)
          (0...k).inject(1){ |m,i| (m * (n - i)) / (i + 1) }.to_d
        end

        def smooth(points,point,opts)
          if point_needed?(point,opts)
            smooth(points,new_point(points,point,point.previous_neighbor),opts)
            if point_needed?(point,opts)
              smooth(points,new_point(points,point,point.next_neighbor),opts)
            end
          end
        end

        # is the angle more than the tolerance?
        def point_needed?(point,opts)
          point.angle < Utilities.radians_tolerance(opts)
        end

        def new_point(points,point,neighbor)
          x,y,t = evaluate_curve((point.t + neighbor.t) / 2.0)
          Subpoint.new(x,y,t,points)
        end

        def init_subpoints
          [].tap do |a|
            Subpoint.from_coordinate(@cursor_start,0,a)
            Subpoint.from_coordinate(cursor_end,1,a)
          end
        end

        def set_implicit_control_point!
          if @absolute
            @c1x,@c1y = implied_c1.x,implied_c1.y
          else
            @c1x,@c1y = @cursor_start.relativize(implied_c1)
          end
        end
    end
  end
end