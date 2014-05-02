# encoding: utf-8

require 'spec_helper'

describe Hyperdrive::Middleware::Accept do
  def app
    inner_app = ->(env) { [200, {}, env['hyperdrive.accept'].values.join(", ")] }
    Hyperdrive::Middleware::Accept.new(inner_app)
  end

  it "parses the accept header" do
    get '/', {}, default_rack_env
    last_response.body.must_equal 'application/vnd.hyperdrive.things+hal+json, application/json'
  end
end
