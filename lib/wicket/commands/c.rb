module Wicket
  module Commands
    class C < Command
      def self.arg_count
        6
      end

      def initialize(absolute,cursor_start,c1x,c1y,c2x,c2y,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @c1x = c1x
        @c1y = c1y
        @c2x = c2x
        @c2y = c2y
        @x = x
        @y = y
        @subpoints = []
      end

      # takes 3 coordinates in the form of {x: ..., y: ...}
      def evaluate_angle(start,mid,finish)
        
      end

    end
  end
end