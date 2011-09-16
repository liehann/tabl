require 'spec_helper'

describe Tabl::Dsl do
  before do
    @module = Module.new
    @module.send(:include, Tabl::Dsl)
  end

  it 'should define a column method' do
    @module.should respond_to(:column)
  end

  it 'should define a table method' do
    @module.should respond_to(:table)
  end
  
  it 'should define a columns method' do
    @module.should respond_to(:columns)
  end

  it 'should define a tables method' do
    @module.should respond_to(:tables)
  end

  it 'should define columns' do
    @module.column :foo
    @module.columns[0].name.should == :foo
  end

  it 'should define an include_columns method' do
    @module.should respond_to(:include_columns)
  end

  describe '.table' do
    it 'should define a table' do
      @module.table :foo
      @module.foo.should be_a(Tabl::Table)
    end

    it 'should set base columns' do
      @module.column :foo

      @module.table :foo
      @module.foo.base_columns.should == @module.columns
    end
  end

  describe '.include_columns' do
    before do
      @columns_mod = Module.new
      @columns_mod.send(:include, Tabl::Dsl)
      @columns_mod.column(:foo)
    end

    it 'should include columns' do
      @module.include_columns @columns_mod
      @module.columns.should == @columns_mod.columns
    end

    it 'should take a a deref parameter' do
      @module.include_columns @columns_mod, :record => :bar
      @module.columns[0].should be_a Tabl::DerefColumn
      @module.columns[0].column.should == @columns_mod.columns[0]
    end
  end
end

