module Wicket
  class Subpath
    attr_reader :commands
    def initialize
      @commands = []
    end

    def add_command(*commands)
      @commands += commands
    end

    def cursor_end
      return {:x => 0, :y => 0} unless last_command
      last_command.cursor_end
    end

    def closed?
      return false unless last_command
      first_command.cursor_end == last_command.cursor_end || last_command.is_a?(Commands::Z)
    end

    def to_polygon
      vertices = commands.map(&:to_wkt).join(",")
      "((#{vertices}))"
    end

    private

      def last_command
        @commands.last
      end

      def first_command
        @commands.first
      end
  end
end