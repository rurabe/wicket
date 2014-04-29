module Wicket
  module Commands
    class Z < Command

      def self.arg_count
        1
      end

      def initialize(absolute,cursor_start,*garbage)
        @cursor_start = cursor_start
      end

      def coordinates
        {}
      end
    end
  end
end 