# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::RequiredParams do
  def app
    inner_app = ->(env) { [200, {}, [env['hyperdrive.params'][:id]]] }
    Hyperdrive::Middleware::RequiredParams.new(inner_app)
  end

  before do
    @resource = default_resource
    @env = default_rack_env(@resource).merge('hyperdrive.params' => {})
    @filters = { parent_id: '1000' }
  end

  context "Filters" do
    it "responds successfully if required filter is present" do
      get '/', @filters, @env.merge('hyperdrive.params' => @filters)
      last_response.successful?.must_equal true
    end

    it "raises an error if required filter is missing" do
      ->{ get '/', {}, @env }.must_raise Hyperdrive::Errors::MissingRequiredParam
    end

    it "raises an error if required filter is missing" do
      ->{ get '/', {}, @env.merge('hyperdrive.params' => { parent_id: '' }) }.must_raise Hyperdrive::Errors::MissingRequiredParam
    end
  end

  context "Params" do
    before do
      @env.merge!('REQUEST_METHOD' => 'PUT')
      @params = { id: '1001', name: 'yoda' }
    end

    it "responds successfully if required params are present" do
      put '/', @params, @env.merge('hyperdrive.params' => @params)
      last_response.successful?.must_equal true
    end

    it "raises an error if required param is missing" do
      ->{ put '/', {}, @env }.must_raise Hyperdrive::Errors::MissingRequiredParam
    end
  end
end
