module Wicket
  module Commands
    class H < Command

      def self.arg_count
        1
      end

      def initialize(absolute,cursor_start,x)
        @absolute = absolute
        @cursor_start = cursor_start
        @x = x
      end

      def coordinates
        {:x => @x, :y => cursor_start[:y]}
      end

      def cursor_end
        if @absolute
          coordinates
        else
          {:x => (@cursor_start[:x] + @x), :y => @cursor_start[:y]}
        end
      end

    end
  end
end