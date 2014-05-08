module Wicket
  module Commands
    class S < Command
      def self.arg_count
        4
      end

      def initialize(absolute,cursor_start,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
      end

    end
  end
end