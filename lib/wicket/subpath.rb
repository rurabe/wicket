module Wicket
  class Subpath
    attr_reader :commands
    def initialize
      @commands = []
    end

    def add_command(*new_commands)
      new_commands.each do |c|
        c.subpath = self
        @commands << c
      end
    end

    def cursor_end
      return {:x => 0, :y => 0} unless last_command
      last_command.cursor_end
    end

    def closed?
      return false if @commands.empty?
      @commands.last.class == Commands::Z
    end

    def to_polygon
      vertices = commands.map(&:to_wkt).join(",")
      "((#{vertices}))"
    end

    def last_command
      @commands.last
    end

    def first_command
      @commands.first
    end
  end
end