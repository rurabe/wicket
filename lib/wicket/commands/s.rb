module Wicket
  module Commands
    class S < Command
      ARGS = 4
      include BezierCurve
      include CubicBezier

      def initialize(absolute,cursor_start,subpath,opts,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        set_implicit_control_point!
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
      end

      private
        def set_implicit_control_point!
          if @absolute
            @c1x,@c1y = implied_c1.x,implied_c1.y
          else
            @c1x,@c1y = @cursor_start.relativize(implied_c1)
          end
        end

        def implied_c1
          last = @subpath.last_command
          case last 
          when C,S
            @cursor_start.reflect(last.c2)
          else 
            @cursor_start
          end 
        end




    end
  end
end