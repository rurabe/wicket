module Wicket
  class Command
    attr_reader :cursor_start

    class << self
      def from_code(code,arg_string,subpath)
        command_class = Commands.const_get(code.upcase) # get the class which handles this code
        absolute = (code.upcase == code) # is it uppercase?
        cursor_start = subpath.cursor_end # get the current position of the cursor
        args = arg_string.scan(/(?:\-\s*)?\d+(?:\.\d+)?/).flatten # parse out the numerical arguments
        args.each_slice(command_class.arg_count).map do |slice| # slice them according to the number the code takes
          slice.map!{|arg| arg.gsub(/\s*/,'').to_f } # remove whitespace and turn into a float
          command_class.new(absolute,cursor_start,*slice)
        end
      end
    end

    def inspect
      "#<#{self.class.to_s} #{coordinates.map{|k,v|[k,v].join("=")}.join(",")}#{" abs" if @absolute}>"
    end
  end
end