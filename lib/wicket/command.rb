module Wicket
  class Command

    class << self
      def from_code(code,arg_string)
        command_class = Commands.const_get(code.upcase)
        absolute = (code.upcase == code) # is it uppercase?
        args = arg_string.scan(/(?:\-\s*)?\d+(?:\.\d+)?/).flatten
        args.each_slice(command_class.arg_count).map do |slice|
          command_class.new(absolute,*slice)
        end
      end
    end

    def inspect
      "#<#{self.class.to_s} #{coordinates.map{|k,v|[k,v].join("=")}.join(",")}#{" abs" if @absolute}>"
    end
  end
end