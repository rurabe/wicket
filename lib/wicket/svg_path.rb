module Wicket
  class SVGPath
    attr_reader :text
    def initialize(text)
      @text = text
    end

    def to_polygon
      parse
    end

    def to_multipolygon
      
    end

    private

      def parse
        @text.scan(/(?:([MmLlHhVvQqCcTtSsAaZz])([\d\.\,\-\s]+)*)/).map do |(code,arg_string)|
          Command.from_code(code,arg_string)
        end
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