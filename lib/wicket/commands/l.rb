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

      def cursor_end
        if @absolute
          coordinates
        else
          {:x => (@cursor_start[:x] + @x), :y => (@cursor_start[:y] + @y)}
        end
      end

    end
  end
end