# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Docs do
  before do
    sample_api
    @docs = Hyperdrive::Docs.new(hyperdrive.resources)
  end

  it 'generates a header with size 1 as default' do
    @docs.header('Thing Resource').must_equal "\n\n# Thing Resource\n\n"
  end

  it 'generates a header only between size 1 and 6' do
    proc {@docs.header('Thing Resource', 0)}.must_raise ArgumentError
    proc {@docs.header('Thing Resource', 8)}.must_raise ArgumentError
  end

  it 'generates a paragraph' do
    @docs.paragraph('Description of Thing Resource').must_equal "Description of Thing Resource\n\n"
  end 

  it 'generates bold text' do
    @docs.bold('name').must_equal '__name__'
  end

  it 'generates code formatted text' do
    @docs.code('/things').must_equal '`/things`'
  end

  it 'generates a bullet with nest level of 1 as default' do
    @docs.bullet('test').must_equal "  - test\n"
  end

  it 'generates a bullet with nest level between 1 and 3' do
    proc {@docs.bullet('test', 4)}.must_raise ArgumentError
    proc {@docs.bullet('test', 0)}.must_raise ArgumentError
  end

  it 'generates a nested bulleted list' do
    @docs.bullet('test', 2).must_equal "    - test\n"
  end

  it 'generates a nested bullet code span' do
    @docs.bullet('`/things`', 2).must_equal "    - `/things`\n"
  end

  it 'generates nested bulleted bold text' do
    @docs.bullet('__id__', 3).must_equal "      - __id__\n"
  end

  it 'outputs a string of the completed doc' do
    @docs.output.must_be_kind_of String
  end
end