module Wicket
  class Command
    attr_reader :cursor_start, :x, :y

    class << self
      def from_code(code,arg_string,subpath)
        command_class = Commands.const_get(code.upcase) # get the class which handles this code
        absolute = (code.upcase == code) # is it uppercase?
        cursor_start = subpath.cursor_end # get the current position of the cursor
        args = arg_string.to_s.scan(/(?:\-\s*)?\d+(?:\.\d+)?/).flatten # parse out the numerical arguments
        if !args.empty?
          generate_commands(args,command_class,absolute,cursor_start)
        else # Must be a Z command
          [command_class.new(absolute,cursor_start)]
        end
      end

      private

        def generate_commands(args,command_class,absolute,cursor_start)
          args.each_slice(command_class::ARGS).map do |slice| # slice them according to the number the code takes
            slice.map!{|arg| BigDecimal.new(arg.gsub(/\s*/,'')) } # remove whitespace and turn into a decimal
            command_class.new(absolute,cursor_start,*slice)
          end
        end
    end

    def subpath=(subpath)
      @subpath = subpath
    end

    def absolute_x
      @absolute ? x : cursor_start.x + ( @x || 0 )
    end

    def absolute_y
      @absolute ? y : cursor_start.y + ( @y || 0 )
    end

    def cursor_end
      Coordinate.new(absolute_x,absolute_y)
    end

    def inspect
      "#<#{self.class.to_s} x:#{@x},y:#{@y} #{" abs" if @absolute}>"
    end

    def to_wkt
      inverse_values.join(" ")
    end

      private
        def inverse_values
          [cursor_end.x.to_s("F"), (cursor_end.y * -1).to_s("F")]
        end
  end
end