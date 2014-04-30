module Wicket
  class SVGPath
    attr_reader :text, :subpaths
    def initialize(text)
      @text = text
      @subpaths = []
      parse
    end

    def to_polygon
      poly = subpaths.first.to_polygon
      "POLYGON#{poly}"
    end

    def to_multipolygon
      polys = subpaths.map(&:to_polygon).join(",")
      "MULTIPOLYGON(#{polys})"
    end

    private

      def parse
        commands = @text.scan(/(?:([MmLlHhVvQqCcTtSsAaZz])([\d\.\,\-\s]+)*)/)
        commands.each_with_index.inject(new_subpath) do |subpath,((code,arg_string),index)|
          # pass the code and arguments for parsing into individual commands and add them to the subpath
          subpath.add_command( *Command.from_code(code,arg_string,subpath) )
          # if the path closes, provision a new subpath for future commands unless done
          (subpath.closed? && (index + 1) < commands.length) ? new_subpath : subpath
        end
      end

      def new_subpath
        Subpath.new.tap {|s| @subpaths << s }
      end

      def group_by_subpath(parsed_result)
        parsed_result.each_with_object([]) do
        end
      end

      def parse_arg_string(arg_string)
        matches = arg_string.scan(/(?:\-\s*)?\d+(?:\.\d+)?/)
        matches.flatten.map!{|arg| arg.gsub(/\s*/,'').to_f }
      end
  end
end