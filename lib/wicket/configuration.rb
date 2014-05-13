module Wicket
  class Configuration
    SETTINGS = [
      :min_angle,
      :min_angle_unit
    ]
    attr_accessor *SETTINGS

    def initialize
      @min_angle = 165
    end

    def merge(*opts)
      opts.each_with_object(to_h) do |opts,aggregate|
        aggregate.merge!(opts)
      end
    end

    private

      def to_h
        SETTINGS.each_with_object({}){|s,h| h.merge!(s => send(s)) }
      end

  end
end