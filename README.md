# Tabl - Creating Tables and Reports the Easy Way

## Table Definitions

Create a table definition:
    class UserTables
      table :table do |config|
        config.columns = [
          :name,
          :email,
          :phone_number
        ]
      end
    end

By default this creates a table with the columns specified. The column labels are the symbols titleized. Eg:
* Name
* Email
* Phone Number

The values will evaluate to calling column method on the record:
* `user.name`
* `user.email`
* `user.phone_number`

Both of these can be overridden:
    class UserTables
      table :table do |config|
        config.columns = [
          :name,
          :email,
          :phone_number
        ]

        config.labels[:name] = 'Full Name'

        config.values[:name] = lambda { |user| user.name.upcase }
      end
    end


## Outputting

Tabl outputs to CSV:
    users = Users.all
    UserTables.table.to_csv(users)

Currently html output needs to be done manually:
    %table
      %thead
        %tr
          - UserTables.table.labels.each do |label|
            %th&= label
      %tbody
        - users.each do |user|
          %tr
            - UserTables.table.values.each do |value|
              %td&= value

## Default Value

A default value can be used if values are null. For example it may be preferable to display a dash instead of an empty column.
    fmt = UserTables.table.format do |config|
      config.default_value = '-'
    end


## Formatting

Different formats can be defined for the same table definition. This allows the values to be computed differently. For example for html by default values should be escaped.
    fmt = UserTables.table.format do |config|
      config.default_format = lambda { |v| h(v) }
    end

This can be overridden per column, allowing some columns to be formatted as links.
    fmt = UserTables.table.format do |config|
      # The second parameter is optional.
      config.format[:name] = lambda { |name, line| link_to v, line }
    end

## Shared Definitions

Sometimes definitions are common over several tables. In this case a definition can be configured in a module and included into table definitions.
    module UserColumns
      # Specify what part of the record is required. This is typically an association.
      record :user

      # Columns can be configured using a hash.
      column :name, :label => 'User', :value => lambda {|v| user.name.upcase}

      # Or using a block.
      column :name do |config|
        config.label = 'User'
        config.value = lambda { |user| user.name.upcase }
        config.format.html = lambda { |name, user| link_to name, user }
      end
    end

This shared definition can then be used in other tables. The shared definition is only invoked if the record returns a non-nil object. If the record is not defined the base object is assumed to be the record.
    module JobTables
      include UserColumns

      table :jobs_report do |config|
        config.records[:user] = lambda { |job| job.user }
      end
    end
    
    module UserTables
      table :users_report do |config|
        # Implicitly equivalent to:
        # config.records[:user] => lambda { |user| user }
      end
    end

## More Formatting

Default format objects can be created. HTML is a default built in format.
    module UserTables
      table :user_report do |config|
        config.format(:html) do |format|
          format.format[:name] = lambda { |name, line| link_to v, line }
        end
      end
    end

This format can be accessed from the table.
    fmt = UserTables.user_report.format(:html)

To define formatting on shared definitions:
    module UserColumns
      column :name do |config|
        config.format[:html] = lambda { |name, line| link_to v, line }
      end
    end

To create a custom built in format:
    class HtmlFormatter
      Tabl::Formatters.register(:html, HtmlFormatter)

      def default_value
        '-'
      end

      def default_format(value)
        h(value)
      end
    end
    
    UserTables.user_report.html.formatted_values(user)

