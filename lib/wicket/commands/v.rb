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

      def coordinates
        {:x => cursor_start[:x], :y => @y}
      end

      def cursor_end
        if @absolute
          coordinates
        else
          {:x => @cursor_start[:x], :y => (@cursor_start[:y] + @y)}
        end
      end

    end
  end
end