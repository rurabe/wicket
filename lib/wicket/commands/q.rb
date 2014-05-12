module Wicket
  module Commands
    class Q < Command
      ARGS = 4
      include QuadraticBezier

      def initialize(absolute,cursor_start,subpath,opts,c1x,c1y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @c1x = c1x
        @c1y = c1y
        @x = x
        @y = y
      end

    end
  end
end