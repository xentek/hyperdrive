# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::RequestMethod do
  def app
    inner_app = ->(env) { [200, {}, ['']] }
    Hyperdrive::Middleware::RequestMethod.new(inner_app)
  end

  before do
    @resource = default_resource
    @env = default_rack_env(@resource)
  end

  it "is successful if the request method is supported" do
    get '/', {}, @env
    last_response.successful?.must_equal true
  end

  it "throws an error if hyperdrive doesn't support the request method" do
    ->{ request('/', @env.merge('REQUEST_METHOD' => 'TRACE')) }.must_raise Hyperdrive::Errors::NotImplemented
  end

  it "throws an error if the resource doesn't support the request method" do
    ->{ post('/', {}, @env.merge('REQUEST_METHOD' => 'POST')) }.must_raise Hyperdrive::Errors::MethodNotAllowed
  end
end
