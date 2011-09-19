module Tabl
  class Table
    attr_reader :keys
    attr_reader :columns

    def initialize(args = {})
      @base_columns = {}
      add_base_columns(args[:base_columns] || {})
      @formats = {}
      @columns = {}
      self.columns=(args[:columns] || [])
      yield self if block_given?
    end

    def add_base_columns(columns)
      columns.each do |column|
        @base_columns[column.name] = column
      end
    end

    def columns
      @columns_cache ||= @keys.map { |key| column(key) }
    end

    def base_columns
      @base_columns.values
    end

    def columns=(keys)
      @keys = keys
      @columns_cache = nil
      @keys.each do |key|
        @columns[key] ||= Column.new(key) unless @base_columns.include?(key)
      end
    end

    def labels
      @keys.map { |key| column(key).label }
    end

    def values(record)
      @keys.map { |key| value(key, record) }
    end

    def value(key, record)
      column(key).value(record)
    end

    def column(key)
      @columns[key] || @base_columns[key]
    end

    def method_missing(name, *args)
      # Check columns first, creating an override if one doesn't exist already.
      column = @columns[name] || (@base_columns.include?(name) && @columns[name] = @base_columns[name].clone)
      if column
        yield column if block_given?
        return column
      end

      # Check formats next
      format = @formats[name]
      return format if format

      # Create a new format object
      format_base = Formats.send(name) || super
      @formats[name] = Format.new(name, self, format_base)
    end

    def to_csv(records)
      FasterCSV.generate do |csv|
        csv << labels
        records.each do |record|
          csv << values(record)
        end
      end
    end

    class Format
      def initialize(name, table, base)
        @name = name
        @table = table
        @base = base
      end

      def values(record, context = nil)
        @table.keys.map do |key|
          value = @table.value(key, record)
          if value
            format(key, value, record, context)
          else
            @base.default_value
          end
        end
      end

      def format(key, value, record, context)
        column = @table.column(key)

        if column.formats[@name]
          column.format(@name, value, record, context)
        else
          @base.format(value)
        end
      end
    end
  end
end

