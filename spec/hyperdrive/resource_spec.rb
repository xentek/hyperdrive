require 'spec_helper'

describe Hyperdrive::Resource do
  before do
    @resource = Hyperdrive::Resource.new(:thing)
    @resource.register_param(:name, 'Thing Name')
    @resource.register_filter(:parent_id, 'Parent ID', required: true)
    @resource.register_request_handler(:get, Proc.new { |env| 'v1' })
    @resource.register_request_handler(:get, Proc.new { |env| 'v2' }, 'v2')
    @media_types = ["application/vnd.hyperdrive.things.v2+hal+json",
                    "application/vnd.hyperdrive.things.v1+hal+json",
                    "application/vnd.hyperdrive.things+hal+json",
                    "application/vnd.hyperdrive+hal+json",
                    "application/vnd.hyperdrive.things.v2+json",
                    "application/vnd.hyperdrive.things.v1+json",
                    "application/vnd.hyperdrive.things+json",
                    "application/vnd.hyperdrive+json",
                    "application/vnd.hyperdrive.things.v2+text/html", 
                    "application/vnd.hyperdrive.things.v1+text/html", 
                    "application/vnd.hyperdrive.things+text/html", 
                    "application/vnd.hyperdrive+text/html"]
  end

  it "has an ID" do
    @resource.id.must_equal "hyperdrive:things"
  end

  it "has a namespace" do
    @resource.namespace.must_equal 'things'
  end

  it "has an endpoint" do
    @resource.endpoint.must_equal '/things'
  end

  it "has a name" do
    @resource.name = 'Thing'
    @resource.name.must_equal 'Thing'
  end

  it "has a description" do
    @resource.description = 'Thing Description'
    @resource.description.must_equal 'Thing Description'
  end

  it "auto-registers the :id param" do
    @resource.params[:id].description.must_equal 'Identifier'
  end

  it "registers a param" do
    @resource.params[:name].description.must_equal 'Thing Name'
  end

  it "returns true if the param is required for the given HTTP Method" do
    @resource.required_param?(:name, 'POST').must_equal true
  end

  it "returns false if the param is not required for the given HTTP Method" do
    @resource.required_param?(:name, 'DELETE').must_equal false
  end

  it "auto-registers the :id filter" do
    @resource.filters[:id].description.must_equal 'Resource Identifier'
  end

  it "registers a filter" do
    @resource.filters[:parent_id].description.must_equal 'Parent ID'
  end

    it "returns true if the filter is required for the given HTTP Method" do
    @resource.required_filter?(:parent_id, 'GET').must_equal true
  end

  it "returns false if the filter is not required for the given HTTP Method" do
    @resource.required_filter?(:parent_id, 'OPTIONS').must_equal false
  end

  it "returns true if the param (or filter) is required" do
    @resource.required?(:name, 'POST').must_equal true
  end

  it "returns true if the filter (or param) is required" do
    @resource.required?(:parent_id, 'GET').must_equal true
  end

  it "returns false if the param (or filter) is not required" do
    @resource.required?(:name, 'GET').must_equal false
  end

  it "returns false if the filter (or param) is not required" do
    @resource.required?(:parent_id, 'DELETE').must_equal false
  end

  it "registers a request handler" do
    @resource.request_handlers[:get]['v1'].must_be :===, Proc
  end

  it "auto-registers HEAD request handler when GET handler is registered" do
    @resource.request_handlers[:head]['v1'].must_be :===, Proc
  end

  it "returns the specified request handler" do
    @resource.request_handler('GET').must_be :===, Proc
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
    @resource.request_handler('GET', 'v2').must_be :===, Proc
  end

  it "returns the acceptable content types" do
    @resource.acceptable_content_types('GET').must_equal @media_types
  end

  it "returns the available versions for this resource" do
    @resource.available_versions('GET').must_equal ['v2','v1']
  end

  it "returns the latest available version for this resource" do
    @resource.latest_version('GET').must_equal 'v2'
  end

  it "returns a hash representation of the resource" do
    @resource.to_hash.must_be_kind_of Hash
  end

  context "compound namspaces" do
    before do
      @compound_resource = Hyperdrive::Resource.new(:goof_ball)
    end

    it "has an ID" do
      @compound_resource.id.must_equal "hyperdrive:goof:balls"
    end

    it "has a namespace" do
      @compound_resource.namespace.must_equal 'goof:balls'
    end

    it "has an endpoint" do
      @compound_resource.endpoint.must_equal '/goof/balls'
    end
  end

  context "options" do
    before do
      @resource_with_options = Hyperdrive::Resource.new(:great_thing, endpoint: '/great-things')
    end

    it "has an ID" do
      @resource_with_options.id.must_equal "hyperdrive:great:things"
    end

    it "has a namespace" do
      @resource_with_options.namespace.must_equal 'great:things'
    end

    it "has an endpoint" do
      @resource_with_options.endpoint.must_equal '/great-things'
    end
  end
end
