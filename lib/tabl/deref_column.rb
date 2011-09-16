module Tabl
  class DerefColumn
    attr_reader :column

    def initialize(column, deref)
      @column = column
      @callback = deref
      @callback = lambda { |record| record.send(deref) } if Symbol === deref
    end

    def value(record)
      super(deref(record))
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


