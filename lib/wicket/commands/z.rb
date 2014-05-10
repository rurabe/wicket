module Wicket
  module Commands
    class Z < Command
      ARGS = 1

      def initialize(absolute,cursor_start,opts={})
        @cursor_start = cursor_start
        @opts = opts
      end

      def cursor_end
        @subpath.first_command.cursor_end
      end
    end
  end
end 