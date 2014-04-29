module Wicket
  module Commands
    class L < Command

      def self.arg_count
        2
      end

      def initialize(absolute,cursor_start,x,y)
        @absolute = absolute
        @x = x
        @y = y
        @cursor_start = cursor_start
      end

      def coordinates
        {:x => @x, :y => @y}
      end

    end
  end
end