module Wicket
  module Commands
    class M < Command
      ARGS = 2
      ARG_LIST = [:x,:y]

      def initialize(absolute,cursor_start,subpath,opts,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
        @x = x
        @y = y
      end

    end
  end
end