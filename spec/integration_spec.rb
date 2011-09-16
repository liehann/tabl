require 'spec_helper'
require 'lib/user_columns'
require 'lib/post_tables'

describe PostTables do
  it 'should return csv' do
    post = OpenStruct.new(:post => 'foo', :user => OpenStruct.new(:first_name => 'John', :last_name => 'Smith'))
    PostTables.posts.to_csv([post]).should == <<CSV
Post,User
foo,John Smith
CSV
  end
end


