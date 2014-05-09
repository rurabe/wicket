module Wicket
  module Commands
    class H < Command
      ARGS = 1

      def initialize(absolute,cursor_start,x)
        @absolute = absolute
        @cursor_start = cursor_start
        @x = x
      end

      def absolute_y
        @cursor_start.y
      end
    end
  end
end