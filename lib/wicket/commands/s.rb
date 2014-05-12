module Wicket
  module Commands
    class S < Command
      ARGS = 4

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
          case last = @subpath.last_command
          when C,S

          else

          end
        end

        def coincident_control_point
          @c1x = @cursor_start.x
          @c1y = @cursor_start.y
        end

    end
  end
end