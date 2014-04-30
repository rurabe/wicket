module Wicket
  module Commands
    class Z < Command

      def self.arg_count
        1
      end

      def initialize(absolute,cursor_start)
        @cursor_start = cursor_start
      end

      def coordinates
        {}
      end

      def cursor_end
        @subpath.first_command.cursor_end
      end
    end
  end
end 