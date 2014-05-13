module Wicket
  module Commands
    class H < Command
      ARGS = 1
      ARG_LIST = [:x]

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
        o = @opts.merge(opts)
        "H #{Utilities.format(absolute_x,o)}"
      end
    end
  end
end