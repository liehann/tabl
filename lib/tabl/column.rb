module Tabl
  class Column
    attr_reader :name
    attr_accessor :label
    attr_writer :value

    def initialize(name, args = {})
      @name = name
      @label = args[:label] || @name.to_s.titleize
      @value = args[:value] || lambda { |record| record.send(@name) }
      @formats = Formats.new
      yield self if block_given?
    end

    def value(record)
      @value.call(record)
    end

    def format(name = nil)
      @formats
    end

    class Formats
      def initialize
        @formats = {}
      end

      def [](name)
        @formats[name]
      end

      def method_missing(name, *args)
        name = name.to_s
        assign = (name =~ /=$/)
        key = name.gsub(/=$/, '').to_sym

        # super unless Tabl.formats.include?(key)

        if (assign)
          write(key, *args)
        else
          read(key, *args)
        end
      end

      def write(key, proc)
        @formats[key] = proc
      end

      def read(key, value = nil, record = nil)
        format = @formats[key]
        return format unless value
        if (format.arity == 1)
          return format.call(value)
        else
          return format.call(value, record)
        end
      end
    end
  end
end


