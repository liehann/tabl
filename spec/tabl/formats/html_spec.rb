require 'spec_helper'

describe Tabl::Formats::Html do
  it 'should register under :html' do
    Tabl::Formats.html.should == Tabl::Formats::Html
  end

  it 'should escape html' do
    Tabl::Formats::Html.format('<').should == '&lt;'
  end
end
