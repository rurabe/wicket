module Wicket
  module Commands
    class L < Command
      ARGS = 2

      def initialize(absolute,cursor_start,x,y,opts={})
        @absolute = absolute
        @cursor_start = cursor_start
        @x = x
        @y = y
        @opts = opts
      end

    end
  end
end