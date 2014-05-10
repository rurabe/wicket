module Wicket
  module Commands
    class M < Command
      ARGS = 2

      def initialize(absolute,cursor_start,subpath,opts,x,y)
        @absolute = absolute
        @cursor_start = cursor_start
        @subpath = subpath
        @x = x
        @y = y
      end

    end
  end
end