module Wicket
  module Commands
    class M < Command

      def self.arg_count
        2
      end

      def initialize(absolute,cursor_start,x,y)
        @absolute = absolute
        @x = x
        @y = y
        @cursor_start = cursor_start
      end

    end
  end
end