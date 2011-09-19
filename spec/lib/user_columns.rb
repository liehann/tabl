class UserColumns
  include Tabl::Dsl

  column :user do |column|
    column.value = lambda { |user| [ user.first_name, user.last_name ].join(' ') }
    column.format.html = lambda { |value, user| link_to value, "/user/#{user.key}" }
  end
end

