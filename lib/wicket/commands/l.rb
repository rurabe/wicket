module Wicket
  module Commands
    class L < Command

      class << self
        def arg_count
          2
        end
      end

      def initialize(absolute,x,y)
        @absolute = absolute
        @x = x
        @y = y
      end

      def coordinates
        {:x => @x, :y => @y}
      end

    end
  end
end