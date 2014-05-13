module Wicket
  module Cartesian

    def distance_to(remote)
      Math.sqrt((remote.x - x) ** 2 + (remote.y - y) ** 2)
    end

    def to_wkt(o={})
      [format(x,o),format((y * -1),o)].join(" ")
    end

    def to_svg(o={})
      [x,y].map{|a| format(a,o)}.join(",")
    end 

    private

      def format(n,opts={})
        Utilities.format(n,opts)
      end

  end
end