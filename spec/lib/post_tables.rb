module PostTables
  include Tabl::Dsl

  include_columns UserColumns, :record => :user

  table :posts do |table|
    table.columns = [ :post, :user ]
  end

end

