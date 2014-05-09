module Wicket
  module Commands
    module BezierCurve

      def linearize!
        @subpoints.each_slice(2) do |(prev_sub,next_sub)|
          # create the midpoint, and evaluate the angle created
          # if the angle meets the threshold, add it to the subpoints array
        end
      end

      def evaluate_curve(t)
        Subpoint.new( *([:x,:y].map{|c| de_casteljau(c,t,*control_points) }),t,self )
      end
      private

        def de_casteljau(axis,t,*points)
          n = (points.length - 1)
          points.each_with_index.inject(0) do |m,(p,i)|
            m + ( choose(n,i) * ((1-t) ** (n-i)) * (t ** i) * p.send(axis))
          end
        end

        def choose(n,k)
          (0...k).inject(1){ |m,i| (m * (n - i)) / (i + 1) }
        end

    end
  end
end