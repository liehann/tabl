require 'spec_helper'

describe Tabl::Column do
  it 'should have a label' do
    column = Tabl::Column.new(:foo)
    column.label.should == 'Foo'
  end

  it 'should product a value' do
    foo = OpenStruct.new(:foo => 'foo')
    column = Tabl::Column.new(:foo)
    column.value(foo).should == 'foo'
  end

  it 'should allow setting the label' do
    column = Tabl::Column.new(:foo)
    column.label = 'Bar'
    column.label.should == 'Bar'
  end

  it 'should allow overriding the value function' do
    foo = OpenStruct.new(:bar => 'bar')
    column = Tabl::Column.new(:foo)
    column.value = lambda { |foo| foo.bar }
    column.value(foo).should == 'bar'
  end

  it 'should allow setting the format' do
    foo = OpenStruct.new(:foo => 'foo')
    column = Tabl::Column.new(:foo)
    column.format.html = lambda { |v| v.upcase }
    column.format.html('foo', foo).should == 'FOO'
  end

  it 'should yield a configuration block' do
    column = Tabl::Column.new(:foo) do |config|
      config.label = 'Foo'
      config.value = lambda { |foo| foo.bar }
      config.format.html = lambda { |v| v.upcase }
    end

    foo = OpenStruct.new(:bar => 'bar')

    column.label.should == 'Foo'
    column.value(foo).should == 'bar'
    column.format.html('bar').should == 'BAR'
  end
end

