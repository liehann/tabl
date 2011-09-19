module Tabl
  class DerefColumn
    attr_reader :column

    def initialize(column, deref)
      @column = column
      @callback = deref
      @callback = lambda { |record| record.send(deref) } if Symbol === deref
      @format_dsl = Column::FormatDsl.new(self)
    end

    def value(record)
      @column.value(deref(record))
    end

    def format(format = nil, value = nil, record = nil, context = nil)
      if format.nil?
        @format_dsl
      else
        record = deref(record) if record
        @column.format(format, value, record, context)
      end
    end

    def deref(record)
      @callback.call(record)
    end

    def method_missing(name, *args)
      @column.send(name, *args)
    end

    def clone
      DerefColumn.new(@column.clone, @callback.clone)
    end
  end
end


