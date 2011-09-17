require 'spec_helper'

describe Tabl::Table do
  it 'should yield a configure block' do
    yielded = false
    table = Tabl::Table.new do |config|
      yielded = true
    end
    yielded.should == true
  end

  it 'should return labels' do
    table = Tabl::Table.new do |config|
      config.columns = [ :user, :email, :phone_number ]
    end
    table.labels.should == ['User', 'Email', 'Phone Number']
  end

  it 'should return values' do
    table = Tabl::Table.new do |config|
      config.columns = [ :user, :email, :phone_number ]
    end
    user = OpenStruct.new(:user => 'fred', :email => 'fred@foo.com', :phone_number => '12345678')
    table.values(user).should == ['fred', 'fred@foo.com', '12345678']
  end

  it 'should format values' do
    table = Tabl::Table.new do |config|
      config.columns = [ :user, :email, :phone_number ]
    end
    user = OpenStruct.new(:user => '<>', :email => 'fred@foo.com', :phone_number => '12345678')
    table.html.values(user).should == ['&lt;&gt;', 'fred@foo.com', '12345678']
  end

  it 'should override formats' do
    table = Tabl::Table.new do |config|
      config.columns = [ :user, :email, :phone_number ]
      config.email.format.html = lambda { |v| v.upcase }
    end
    user = OpenStruct.new(:user => '<>', :email => 'fred@foo.com', :phone_number => '12345678')
    table.html.values(user).should == ['&lt;&gt;', 'FRED@FOO.COM', '12345678']
  end

  it 'should have base columns' do
    base_columns = [ Tabl::Column.new(:foo, :value => lambda { |record| record.foo.bar }) ]
    table = Tabl::Table.new(:base_columns => base_columns, :columns => [:foo])
    foo = OpenStruct.new(:foo => OpenStruct.new(:bar => 'bar'))
    table.values(foo).should == ['bar']
  end

  it 'should format dereferenced columns' do
    foo_column = Tabl::DerefColumn.new(Tabl::Column.new(:foo), :bar)
    table = Tabl::Table.new(:base_columns => [foo_column], :columns => [:foo])
    bar = OpenStruct.new(:bar => OpenStruct.new(:foo => 'foo'))
    table.html.values(bar).should == ['foo']
  end
end


