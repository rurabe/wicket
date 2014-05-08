module Wicket
  class Coordinate < Struct.new(:x,:y)
    def shift(rel_x,rel_y)
      new_x = x + ( rel_x || zero )
      new_y = y + ( rel_y || zero )
      self.class.new(new_x,new_y)
    end

    def distance_to(remote_coord)
      
    end

    private

      def zero
        BigDecimal.new(0)
      end
  end
end