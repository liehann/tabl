require 'spec_helper'
require 'lib/user_columns'
require 'lib/post_tables'

describe PostTables do
  it 'should return csv' do
    post = OpenStruct.new(:post => 'foo', :user => OpenStruct.new(:id => 1, :first_name => 'John', :last_name => 'Smith'))
    PostTables.posts.to_csv([post]).should == <<CSV
Post,User
foo,John Smith
CSV
  end

  it 'should format values for html' do
    post = OpenStruct.new(:post => '<>', :user => OpenStruct.new(:key => 1, :first_name => 'John', :last_name => 'Smith'))
    PostTables.posts.html.values(post).should == ['&lt;&gt;', "<a href='/user/1'>John Smith</a>"]
  end
end


