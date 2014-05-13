module Wicket
  module Commands
    class T < Command
      ARGS = 2
      include QuadraticBezier
      ARG_LIST = [:x,:y]

      def initialize(absolute,cursor_start,subpath,opts,x,y)        
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        set_implicit_control_point!
        @x = x
        @y = y
      end

      private

        # > The control point is assumed to be the reflection of the control point on
        # > the previous command relative to the current point. (If there is no previous
        # > command or if the previous command was not a Q, q, T or t, assume the control
        # > point is coincident with the current point.)
        # > http://www.w3.org/TR/SVG11/paths.html#PathDataQuadraticBezierCommands
        def implied_c1
          last = @subpath.last_command
          case last
          when Q,T then @cursor_start.reflect(last.c1)
          else @cursor_start
          end
        end
    end
  end
end