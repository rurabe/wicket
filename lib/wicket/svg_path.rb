module Wicket
  class SVGPath
    attr_reader :text
    def initialize(text,opts={})
      @text = text
      @opts = default_opts.merge(opts)
      @subpaths = []
      parse
    end

    def to_polygon
      poly = @subpaths.first.to_polygon
      "POLYGON#{poly}"
    end

    def to_multipolygon
      polys = @subpaths.map(&:to_polygon).join(",")
      "MULTIPOLYGON(#{polys})"
    end

    private

      def parse
        commands = @text.scan(/(?:([MmLlHhVvQqCcTtSsAaZz])([\d\.\,\-\s]+)*)/)
        commands.inject(new_subpath) do |subpath,(code,arg_string)|
          subpath = new_subpath if subpath.closed?
          # pass the code and arguments for parsing into individual commands and add them to the subpath
          subpath.add_command( *Command.from_code(code,arg_string,subpath,@opts) )
        end
      end

      def new_subpath
        Subpath.new.tap {|s| @subpaths << s }
      end

      def default_opts
        Wicket.configuration.to_h
      end
  end
end