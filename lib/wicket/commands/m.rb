module Wicket
  module Commands
    class M < Command

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

      def inspect
        "#<M #{coordinates.map{|k,v|[k,v].join("=")}.join(",")}#{" abs" if @absolute}>"
      end
    end
  end
end