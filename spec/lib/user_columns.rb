class UserColumns
  include Tabl::Dsl

  column :user do |column|
    column.value = lambda { |user| [ user.first_name, user.last_name ].join(' ') }
    column.format.html = lambda { |value, user| "<a href='/user/#{user.key}'>#{ERB::Util.h(value)}</a>" }
  end
end

