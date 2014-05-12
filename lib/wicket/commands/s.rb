module Wicket
  module Commands
    class S < Command
      ARGS = 4
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

        # > The first control point is assumed to be the reflection of the second
        # > control point on the previous command relative to the current point.
        # > (If there is no previous command or if the previous command was not an
        # > C, c, S or s, assume the first control point is coincident with the 
        # > current point.)
        # > http://www.w3.org/TR/SVG11/paths.html#PathDataCubicBezierCommands
        def implied_c1
          last = @subpath.last_command
          case last 
          when C,S then @cursor_start.reflect(last.c2)
          else @cursor_start
          end 
        end
    end
  end
end