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
    @resource.params[:id].description.must_equal 'Identifier'
  end

  it "registers a param" do
    @resource.register_param(:name, "Thing's Name")
    @resource.params[:name].description.must_equal "Thing's Name"
  end

  it "auto-registers the :id filter" do
    @resource.filters[:id].description.must_equal 'Resource Identifier'
  end

  it "registers a filter" do
    @resource.register_filter(:parent_id, 'Parent ID of Thing', required: true)
    @resource.filters[:parent_id].description.must_equal 'Parent ID of Thing'
  end

  context "Request Handlers" do
    before do
      @resource.register_request_handler(:get, Proc.new { |env| 'ok' })
    end

    it "registers a request handler" do
      @resource.request_handlers[:get]['v1'].call(default_rack_env).must_equal 'ok'
    end

    it "returns the specified request handler" do
      @resource.request_handler('GET').call(default_rack_env).must_equal 'ok'
    end

    it "returns true if the request can be handled" do
      @resource.request_method_allowed?('GET').must_equal true
    end

    it "returns false if the request can not be handled" do
      @resource.request_method_allowed?('POST').must_equal false
    end

    it "returns the request methods that can handled" do
      @resource.allowed_methods.must_equal ['OPTIONS','GET','HEAD']
    end

    it "returns the request handler for the specified version" do
      @resource.register_request_handler(:get, Proc.new { |env| 'v2' }, 'v2')
      @resource.request_handler('GET', 'v2').call(default_rack_env).must_equal 'v2'
    end

    it "returns the acceptable content types" do
      @resource.acceptable_content_types('GET').must_equal ["application/vnd.hyperdrive.things.v1+hal+json", "application/vnd.hyperdrive.things+hal+json", "application/vnd.hyperdrive+hal+json", "application/vnd.hyperdrive.things.v1+json", "application/vnd.hyperdrive.things+json", "application/vnd.hyperdrive+json"]
    end

    it "returns the available versions for this resource" do
      @resource.available_versions('GET').must_equal ['v1']
    end

    it "returns the latest available version for this resource" do
      @resource.latest_version('GET').must_equal 'v1'
    end
  end
end
