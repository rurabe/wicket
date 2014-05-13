module Wicket
  module Commands
    class V < Command
      ARGS = 1
      ARG_LIST = [:y]

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

      def to_svg(opts={})
        o = @opts.merge(opts)
        "V #{Utilities.format(absolute_y,o)}"
      end

    end
  end
end