module Wicket
  module Commands
    class V < Command
      ARGS = 1

      def initialize(absolute,cursor_start,subpath,opts,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @y = y
      end

      def absolute_x
        cursor_start.x
      end

    end
  end
end