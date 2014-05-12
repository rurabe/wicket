require "bigdecimal"
require "wicket/version"
require "wicket/utilities"
require "wicket/cartesian"
require "wicket/configuration"
require "wicket/coordinate"
require "wicket/subpoint"
require "wicket/svg_path"
require "wicket/subpath"
require "wicket/commands/bezier_curve"
require "wicket/commands/cubic_bezier"
require "wicket/command"
require "wicket/commands/m"
require "wicket/commands/l"
require "wicket/commands/z"
require "wicket/commands/h"
require "wicket/commands/v"
require "wicket/commands/c"
require "wicket/commands/s"


module Wicket
  class << self
    attr_reader :configuration
    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end
  end
  configure {}
end
