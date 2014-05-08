module Wicket
  module Commands
    class V < Command

      def self.arg_count
        1
      end

      def initialize(absolute,cursor_start,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @y = y
      end

      def x
        cursor_start.x
      end

    end
  end
end