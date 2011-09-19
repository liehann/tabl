module Tabl
  class Column
    attr_reader :name
    attr_accessor :label
    attr_writer :value
    attr_reader :formats

    def initialize(name, args = {})
      @name = name
      @label = args[:label] || @name.to_s.titleize
      @value = args[:value] || lambda { |record| record.send(@name) }
      @formats = {}
      @format_dsl = FormatDsl.new(self)

      yield self if block_given?
    end

    def value(record)
      @value.call(record)
    end

    def format(key = nil, value = nil, record = nil, context = nil)
      if key.nil?
        return @format_dsl
      else
        format = @formats[key]
        return format unless value
        if (context)
          if (format.arity == 1)
            context.instance_exec(value, &format)
          else
            context.instance_exec(value, record, &format)
          end
        else
          if (format.arity == 1)
            return format.call(value)
          else
            return format.call(value, record)
          end
        end
      end
    end

    class FormatDsl
      def initialize(column)
        @column = column
      end

      def method_missing(name, *args)
        name = name.to_s
        assign = (name =~ /=$/)
        key = name.gsub(/=$/, '').to_sym

        if (assign)
          @column.formats[key] = *args
        else
          @column.format(key, *args)
        end
      end
    end
  end
end


