require 'spec_helper'

describe Hyperdrive::Resource do
  before do
    @resource = Hyperdrive::Resource.new(:thing)
  end

  it "has a name" do
    @resource.name = 'Thing'
    @resource.name.must_equal 'Thing'
  end

  it "has a description" do
    @resource.desc = 'Description of Thing Resource'
    @resource.desc.must_equal 'Description of Thing Resource'
  end

  it "has an endpoint" do
    @resource.endpoint.must_equal '/things'
  end

  it "auto-registers the :id param" do
    @resource.allowed_params[:id][:desc].must_equal 'Resource Identifier'
    @resource.allowed_params[:id][:required].must_equal %w(PUT PATCH DELETE)
  end

  it "registers an allowed param" do
    @resource.register_param(:name, "Thing's Name")
    @resource.allowed_params[:name][:desc].must_equal "Thing's Name"
    @resource.allowed_params[:name][:required].must_equal true
  end

  it "auto-registers the :id filter" do
    @resource.filters[:id][:desc].must_equal 'Resource Identifier'
    @resource.filters[:id][:required].must_equal false
  end

  it "registers a filter" do
    @resource.register_filter(:parent_id, 'Parent ID of Thing', required: true)
    @resource.filters[:parent_id][:desc].must_equal 'Parent ID of Thing'
    @resource.filters[:parent_id][:required].must_equal true
  end

  it "defines a request handler" do
    @resource.define_request_handler(:get, Proc.new { return 'ok' })
    @resource.request_handlers[:get].call.must_equal 'ok'
  end

  it "returns the specified request handler" do
    @resource.define_request_handler(:get, Proc.new { return 'ok' })
    @resource.request_handler('GET').call.must_equal 'ok'
  end

  it "returns true if the request can be handled" do
    @resource.define_request_handler(:get, Proc.new { return 'ok' })
    @resource.request_method_allowed?('GET').must_equal true
  end

  it "returns false if the request can not be handled" do
    @resource.request_method_allowed?('GET').must_equal false
  end

  it "returns the request methods that can handled" do
    @resource.define_request_handler(:get, Proc.new { return 'ok' })
    @resource.allowed_methods.must_equal ['OPTIONS','GET','HEAD']
  end
end
