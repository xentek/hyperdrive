# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Error do
  before do
    get '/'
  end
 
  context "Known Error" do
    def app
      Rack::Builder.new do
        use Hyperdrive::Middleware::Error
        run ->(env) { raise Hyperdrive::Errors::MethodNotAllowed.new('GET') }
      end
    end

    it "traps errors" do
      last_response.status.must_equal 405
    end

    it "returns a formatted error message" do
      last_response.body.must_match(/error/)
    end
  end

  context "Unknown Error" do
    def app
      Rack::Builder.new do
        use Hyperdrive::Middleware::Error
        run ->(env) { raise 'Woah there, fella!' }
      end
    end

    it "traps errors" do
      last_response.status.must_equal 500
    end

    it "returns a formatted error message" do
      last_response.body.must_match(/Unknown Error/)
    end
  end
end
