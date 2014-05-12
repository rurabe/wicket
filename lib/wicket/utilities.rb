module Wicket
  module Utilities
    class << self
      def radians_tolerance(opts={})
        t = opts[:min_angle]
        case opts[:min_angle_unit] || determine_tolerance(t)
        when nil,:radians 
          check_range(Math::PI,t)
          t
        when :degrees
          check_range(180,t)
          (t / 180.0) * Math::PI
        when :percentage
          check_range(100,t)
          (t / 100.0) * Math::PI
        when :decimal_percentage
          check_range(1,t)
          t * Math::PI
        end
      end

      private

        def determine_tolerance(t)
          if t > 0 && t < 1
            :decimal_percentage
          elsif t >= 1 && t < Math::PI
            :radians
          elsif t >= Math::PI && t < 100
            :percentage
          elsif t >= 100 && t < 180
            :degrees
          else
            raise_error(0,180)
          end
        end

        def check_range(upper,val)
          raise_error(0,upper) unless val < upper
        end

        def raise_error(lower,upper)
          raise ArgumentError.new("Tolerance must be greater than #{lower} and less than #{upper}")
        end
    end
  end
end