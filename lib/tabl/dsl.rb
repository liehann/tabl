module Tabl
  module Dsl
    def Dsl.included(mod)
      mod.extend(ClassMethods)
    end

    # Defines a dsl to create tables.
    module ClassMethods

      def column(name, args = {}, &block)
        columns_hash[name] = column = Column.new(name, args, &block)
        self.send(:define_method, name) { return column }
        singleton_class.send(:define_method, name) { return column }
      end

      def columns
        columns_hash.values
      end

      # Define a new table.
      #   module UserTables
      #     include Tabl::Dsl
      #     
      #     table :users, [:name, :email, :phone]
      #   end
      #   
      #   MyTables.foo
      #     # => <Table name:foo>
      def table(name, args = {}, &block)
        args[:base_columns] ||= columns
        table = Table.new(args, &block)
        tables << table
        singleton_class.send(:define_method, name) { return table }
      end

      def tables
        @tables ||= []
      end

      # Includes column definitions. These column definitions will be available
      # to any tables defined in the module.
      #
      #   module UserTables
      #     include Tabl::Dsl
      #     
      #     include_columns(UserColumns)
      #   end
      def include_columns(mod, args = {})
        mod.columns.each do |column|
          column = args[:record] ? DerefColumn.new(column, args[:record]) : column
          columns_hash[column.name] = column
        end
      end

      private

      def columns_hash
        @columns_hash ||= {}
      end

    end
  end
end

