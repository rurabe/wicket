module Wicket
  class Configuration
    SETTINGS = [
      :curve_tolerance,
      :curve_tolerance_unit
    ]
    attr_accessor *SETTINGS

    def initialize
      @curve_tolerance = 3.0
    end

    def to_h
      SETTINGS.each_with_object({}){|s,h| h.merge!(s => send(s)) }
    end

  end
end