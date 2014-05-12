module Wicket
  class SVGPath
    attr_reader :text, :subpaths
    def initialize(text,opts={})
      @text = text
      @opts = Wicket.configuration.merge(opts)
      @subpaths = []
      parse
    end

    def to_polygon(opts={})
      poly = @subpaths.first.to_polygon(opts)
      "POLYGON#{poly}"
    end

    def to_multipolygon(opts={})
      polys = @subpaths.map{|s| s.to_polygon(opts) }.join(",")
      "MULTIPOLYGON(#{polys})"
    end

    def to_svg(style="fill:none;stroke:lawngreen")
      paths = @subpaths.map(&:to_svg).join(" ")
      <<-SVG
        <svg>
          <path d="#{@text}" style="fill: slateblue; opacity:0.2"/>
          <path d="#{paths}" style="#{style}" stroke-weight="2"/>
        </svg>
      SVG
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