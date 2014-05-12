module Wicket
  module Commands
    class H < Command
      ARGS = 1

      def initialize(absolute,cursor_start,subpath,opts,x)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @x = x
      end

      def absolute_y
        @cursor_start.y
      end

      def to_svg(opts={})
        "H #{absolute_x}"
      end
    end
  end
end