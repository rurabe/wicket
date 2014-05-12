module Wicket
  module Commands
    class Z < Command
      ARGS = 1

      def initialize(absolute,cursor_start,subpath,opts)
        @cursor_start = cursor_start
        @subpath = subpath
        @opts = opts
      end

      def cursor_end
        @subpath.first_command.cursor_end
      end

      def to_svg
        "Z"
      end
    end
  end
end 