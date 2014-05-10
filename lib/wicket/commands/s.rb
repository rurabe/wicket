module Wicket
  module Commands
    class S < Command
      ARGS = 4

      def initialize(absolute,cursor_start,subpath,opts,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
      end

    end
  end
end