module Wicket
  module Commands
    class M < Command
      ARGS = 2

      def initialize(absolute,cursor_start,opts={},x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @x = x
        @y = y
        @opts = opts
      end

    end
  end
end