module Tabl
  class Definition
    attr_reader :columns
    attr_reader :labels
    attr_reader :values

    attr_reader :format
    attr_accessor :default_format
    attr_accessor :default_value

    def initialize(values_override = nil, &block)
      @columns = []
      @labels = {}
      @values = {}
      @format = {}
      @values_override = values_override
      @default_format = lambda { |v| v }
      @default_value = nil
      configure(&block)
      format = Hash.new { Format.new }
    end

    def configure(&block)
      yield(self) if block_given?
    end

    def columns=(columns)
      @columns = columns.clone
      @columns.each do |key|
        @values[key] ||= default_value_proc(key)
        @labels[key] ||= key.to_s.titleize
      end
    end

    def clone
      other = super
      other.instance_variable_set(:@columns, @columns.clone)
      other.instance_variable_set(:@labels, @labels.clone)
      other.instance_variable_set(:@values, @values.clone)
      other.instance_variable_set(:@format, @format.clone)
      other
    end

    private

    def default_value_proc(key)
      if @values_override && @values_override.respond_to?(key)
        @values_override.method(key)
      else
        lambda { |row| row.send(key) }
      end
    end

  end
end

