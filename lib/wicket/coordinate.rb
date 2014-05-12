module Wicket
  class Coordinate < Struct.new(:x,:y)
    include Cartesian

  end
end