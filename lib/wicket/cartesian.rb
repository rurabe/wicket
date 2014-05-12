module Wicket
  module Cartesian

    def distance_to(remote)
      Math.sqrt((remote.x - x) ** 2 + (remote.y - y) ** 2)
    end

    def to_wkt
      [x.to_s("F"),(y * -1).to_s("F")].join(" ")
    end

    def to_svg
      [x,y].map{|a| a.to_s("F")}.join(",")
    end

  end
end