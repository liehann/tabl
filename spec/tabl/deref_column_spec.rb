require 'spec_helper'

describe Tabl::DerefColumn do
  before do
    @column = Tabl::Column.new(:foo)
    @deref_column = Tabl::DerefColumn.new(@column, :bar)
    @bar = OpenStruct.new(:bar => OpenStruct.new(:foo => 'foo'))
  end

  it 'should dereference the object' do
    @deref_column.value(@bar).should == 'foo'
  end

  it 'it should dereference the object when formatting' do
    @column.format.html = lambda { |value, record| record.foo.upcase }
    @deref_column.format.html('foo', @bar).should == 'FOO'
  end

  it 'should delegate the label' do
    @column.label = 'FOO'
    @deref_column.label.should == 'FOO'
  end

  it 'should delegate the value' do
    @column.value = lambda { |o| o.foo.upcase }
    @deref_column.value(@bar).should == 'FOO'
  end
end

