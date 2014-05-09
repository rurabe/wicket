module Wicket
  module Commands
    class L < Command
      ARGS = 2

      def initialize(absolute,cursor_start,x,y)
        @absolute = absolute
        @x = x
        @y = y
        @cursor_start = cursor_start
      end

    end
  end
end