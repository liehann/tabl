class UserColumns
  include Tabl::Dsl

  column :user do |column|
    column.value = lambda { |user| [ user.first_name, user.last_name ].join(' ') }
  end
end

