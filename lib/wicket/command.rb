module Wicket
  class Command
    attr_reader :cursor_start, :x, :y

    class << self
      def from_code(code,arg_string,subpath,opts={})
        command_class = Commands.const_get(code.upcase) # get the class which handles this code
        absolute = (code.upcase == code) # is it uppercase?
        cursor_start = subpath.cursor_end # get the current position of the cursor
        args = arg_string.to_s.scan(/(?:\-\s*)?\d+(?:\.\d+)?/).flatten # parse out the numerical arguments
        if !args.empty?
          set_scale!(args,opts)
          generate_commands(args,command_class,absolute,cursor_start,subpath,opts)
        else # Must be a Z command
          [command_class.new(absolute,cursor_start,subpath,opts)]
        end
      end

      private

        def generate_commands(args,command_class,absolute,cursor_start,subpath,opts={})
          args.each_slice(command_class::ARGS).map do |slice| # slice them according to the number the code takes
            slice.map!{|arg| BigDecimal.new(arg.gsub(/\s*/,'')) } # remove whitespace and turn into a decimal
            command_class.new(absolute,cursor_start,subpath,opts,*slice)
          end
        end

        def set_scale!(args,opts={})
          opts[:_scale] = [opts[:_scale].to_i,args.map{|s| d = s.split(".")[1]; d ? d.length : 0 }.max].max
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

    def to_wkt(opts={})
      o = @opts.merge(opts)
      cursor_end.to_wkt(o)
    end

    def to_svg(opts={})
      o = @opts.merge(opts)
      [letter,cursor_end.to_svg(o)].join("")
    end

    def arguments
      self.class::ARG_LIST.each_with_object({},&arg_maker)
    end

    private

      def letter
        self.class.to_s.match(/\:\:([^\:]+)$/)[1]
      end

      def arg_maker
        Proc.new do |att,hash|
          hash.merge!(att => instance_variable_get("@#{att}"))
        end
      end



  end
end