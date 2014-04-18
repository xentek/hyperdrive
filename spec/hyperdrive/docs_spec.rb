# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Docs do
  before do
    sample_api
    @docs = Hyperdrive::Docs.new(hyperdrive.resources)
  end

  it 'generates a header with size 1 as default' do
    @docs.header('Thing Resource').must_equal "\n# Thing Resource\n\n"
  end

  it 'generates a header only between size 1 and 6' do
    proc {@docs.header('Thing Resource', 0)}.must_raise ArgumentError
    proc {@docs.header('Thing Resource', 8)}.must_raise ArgumentError
  end

  it 'generates a paragraph' do
    @docs.paragraph('Description of Thing Resource').must_equal "Description of Thing Resource\n"
  end 

  it 'generates bold text' do
    @docs.bold('name').must_equal '__name__'
  end

  it 'generates code formatted text' do
    @docs.code('/things').must_equal '`/things`'
  end

  it 'generates a bullet with nest level of 0 as default' do
    @docs.bullet('test').must_equal '- test'
  end

  it 'generates a nested bulleted list' do
    @docs.bullet('test', 2).must_equal '  - test'
  end

  it 'generates a nested bullet code span' do
    @docs.bullet('`/things`', 2).must_equal '  - `/things`'
  end

  it 'generates nested bulleted bold text' do
    @docs.bullet('__id__', 4).must_equal '    - __id__'
  end

  it 'formats endpoint' do
    @docs.endpoint('/thing').must_equal "  - `/thing`\n"
  end

  it 'formats param names' do
    @docs.param_name('id').must_equal '  - __id__: '
  end

  it 'formats param descriptions' do
    @docs.param_desc('Resource Identifier').must_equal "Resource Identifier\n"
  end

  it 'formats param requirements for default actions' do
    @docs.required(true).must_equal "\n    - __Required__: `GET` `HEAD` `OPTIONS` `POST` `PUT` `PATCH` `DELETE` \n\n"
  end

  it 'generates param' do
    params = @docs.resources[:thing].allowed_params
    @docs.params(params).must_equal "  - __id__: Resource Identifier\n\n    - __Required__: `PUT` `PATCH` `DELETE` \n\n  - __name__: 50 Chars or less\n\n    - __Required__: `GET` `HEAD` `OPTIONS` `POST` `PUT` `PATCH` `DELETE` \n\n  - __start_date__: Format: YYYY-MM-DD\n  - __end_date__: Format: YYYY-MM-DD\n" 
  end

  it 'outputs a string of the completed doc' do
    @docs.output.must_be_kind_of String
  end
end