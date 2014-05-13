module Wicket
  module Commands
    class C < Command
      ARGS = 6
      ARG_LIST = [:c1x,:c1y,:c2x,:c2y,:x,:y]
      include CubicBezier

      def initialize(absolute,cursor_start,subpath,opts,c1x,c1y,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @c1x = c1x
        @c1y = c1y
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
      end


    end
  end
end