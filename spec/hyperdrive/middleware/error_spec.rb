# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Error do
  def app
    Rack::Builder.new do
      use Hyperdrive::Middleware::Error
      run ->(env) { raise Hyperdrive::Errors::HTTPError }
    end
  end

  before do
    @response = %Q({"_links":{"root":{"href":"/","title":"API Root"}},"error":{"type":"HTTPError","message":"Hyperdrive::Errors::HTTPError"}})
    get '/'
  end

  it "traps errors" do
    last_response.status.must_equal 500
  end

  it "returns a formatted error message" do
    last_response.body.must_equal @response
  end
end
