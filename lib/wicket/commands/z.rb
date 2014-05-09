module Wicket
  module Commands
    class Z < Command
      ARGS = 1

      def initialize(absolute,cursor_start)
        @cursor_start = cursor_start
      end

      def cursor_end
        @subpath.first_command.cursor_end
      end
    end
  end
end 